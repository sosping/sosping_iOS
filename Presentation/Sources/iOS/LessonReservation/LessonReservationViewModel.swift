//
//  File.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import SwiftUI
import Domain
import Shared

public protocol LessonReservationViewModelDelegate: AnyObject {
    func weatherDetailButtonTapped()
    func tutorCellButtonTapped(lesson: Lesson)
}

@Observable
public class LessonReservationViewModel: NSObject {
    public weak var delegate: (any LessonReservationViewModelDelegate)?
    
    let beachLocation: BeachLocation
    var lessons: [Lesson] = []
    var selectedDate: Date = .now
    
    @ObservationIgnored let lessonUseCase: LessonUseCaseInterface?
    @ObservationIgnored let loginUseCase: LoginUseCaseInterface?
    
    public init(beachLocation: BeachLocation,
                lessonUseCase: LessonUseCaseInterface? = nil,
                loginUseCase: LoginUseCaseInterface? = nil) {
        self.beachLocation = beachLocation
        self.lessonUseCase = lessonUseCase
        self.loginUseCase = loginUseCase
    }
    
    func onAppeared() {
        Task {
            await fetchLessons(date: .now)
        }
    }
    
    func calendarCellButtonTapped(date: Date) {
        Task {
            await self.fetchLessons(date: date)
        }
    }
    
    func selectedDateOnChanged(date: Date) {
        Task {
            await self.fetchLessons(date: date)
        }
    }
    
    func tutorCellButtonTapped(lesson: Lesson) {
        self.delegate?.tutorCellButtonTapped(lesson: lesson)
    }
    
    private func fetchLessons(date: Date) async {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        await self.lessonUseCase?.fetchBeachLocations(date: formatter.string(from: date)) { [weak self] completion in
            guard let `self` else { return }
            
            switch completion {
            case .success(let success):
                withAnimation(.smooth) {
                    self.lessons = success
                    debugPrint("\(#function) \(self.lessons)")
                }
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
    
    private func requestAccessToken() {
        Task {
            guard let success = await self.loginUseCase?.requestAccessToken(), success else {
                return
            }
        }
    }
}
