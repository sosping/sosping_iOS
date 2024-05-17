//
//  File.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import SwiftUI
import Domain
import Shared

@Observable
public class TutorViewModel: NSObject {
    let lesson: Lesson
    var carear: [String] = []
    
    @ObservationIgnored let tutorUseCase: TutorUseCaseInterface?
    @ObservationIgnored let loginUseCase: LoginUseCaseInterface?
    
    public init(lesson: Lesson, 
                tutorUseCase: TutorUseCaseInterface? = nil, 
                loginUseCase: LoginUseCaseInterface? = nil) {
        self.lesson = lesson
        self.tutorUseCase = tutorUseCase
        self.loginUseCase = loginUseCase
    }
}
