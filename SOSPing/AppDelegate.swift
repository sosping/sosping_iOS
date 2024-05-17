//
//  AppDelegate.swift
//  SOSPing
//
//  Created by 김도형 on 5/18/24.
//

import SwiftUI
import Data
import Domain
import Firebase
import FirebaseCore
import FirebaseMessaging
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
    let loginUseCase = LoginUseCase(repository: LoginRepository())
    let memberUseCase = MemberUseCase(repository: MemberRepository())
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        Messaging.messaging().isAutoInitEnabled = true
        
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
        
        application.registerForRemoteNotifications()
        
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    private func requestAccessToken() {
        Task {
            guard await self.loginUseCase.requestAccessToken() else {
                return
            }
        }
    }
    
    private func sendMemberId(fcmToken: String) async {
        await self.memberUseCase.sendMemberId(fcmToken: fcmToken) { [weak self] completion in
            guard let `self` else { return }
            
            switch completion {
            case .success(let success):
                debugPrint("\(#function) fcm register done")
            case .failure(let failure):
                switch failure {
                case .token:
                    self.requestAccessToken()
                default:
                    return
                }
            }
        }
    }
}

extension AppDelegate : UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("fail: \(#function) -> \(error)")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.banner, .badge, .sound, .list])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let userInfo = response.notification.request.content.userInfo
            
            NotificationCenter.default.post(name: Notification.Name("LookUpData"), object: nil, userInfo: userInfo)
            
            completionHandler()
        }
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let token = fcmToken else {
            subscribeHandling(messaging, didReceiveToken: false)
            
            return
        }
        debugPrint("\(#function) fcm token = \(token)")
        Task {
            await self.sendMemberId(fcmToken: token)
        }
        
        subscribeHandling(messaging, didReceiveToken: true)
    }
    
    func subscribeHandling(_ messaging: Messaging, didReceiveToken: Bool) {
        
    }
}
