//
//  File.swift
//  
//
//  Created by 김도형 on 5/17/24.
//

import Foundation
import Domain
import Shared

public final class LoginRepository: LoginRepositoryInterface {
    private let networkManager = NetworkManager.shared
    
    public init() {}
    
    public func authenticate(body: Login, completion: @escaping (Result<User, APIError>) -> Void) async {
        await networkManager.authenticate(body: body, completion: completion)
    }
    
    public func requestAccessToken() async -> Bool {
        return await networkManager.requestAccessToken()
    }
}
