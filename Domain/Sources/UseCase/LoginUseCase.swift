//
//  File.swift
//  
//
//  Created by 김도형 on 5/17/24.
//

import Foundation
import Shared

public protocol LoginUseCaseInterface {
    init(repository: LoginRepositoryInterface)
    func authenticate(body: Login, completion: @escaping (Result<User, APIError>) -> Void) async
    func requestAccessToken() async -> Bool
}

public final class LoginUseCase: LoginUseCaseInterface {
    private let repository: LoginRepositoryInterface
    
    public init(repository: LoginRepositoryInterface) {
        self.repository = repository
    }
    
    public func authenticate(body: Login, completion: @escaping (Result<User, Shared.APIError>) -> Void) async {
        await self.repository.authenticate(body: body, completion: completion)
    }
    
    public func requestAccessToken() async -> Bool {
        return await self.repository.requestAccessToken()
    }
    
}
