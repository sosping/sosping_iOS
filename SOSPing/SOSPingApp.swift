//
//  SOSPingApp.swift
//  SOSPing
//
//  Created by 김도형 on 5/17/24.
//

import SwiftUI
import SharedDesignSystem

@main
struct SOSPingApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        Font.registerFont()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
