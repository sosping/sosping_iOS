//
//  File.swift
//  
//
//  Created by 김도형 on 5/17/24.
//

import SwiftUI
import Domain
import Shared

@Observable
public class LoginViewModel {
    var login = Login()
    @ObservationIgnored let loginUseCase: LoginUseCaseInterface
    
    public init(loginUseCase: LoginUseCaseInterface) {
        self.loginUseCase = loginUseCase
    }
}
