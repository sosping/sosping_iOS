//
//  File.swift
//  
//
//  Created by 김도형 on 5/17/24.
//

import Foundation
import Shared

public protocol LoginRepositoryInterface {
    init()
    func authenticate(body: Login, completion: @escaping (Result<User, APIError>) -> Void) async
    func requestAccessToken() async -> Bool
}
