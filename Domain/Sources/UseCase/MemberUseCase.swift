//
//  File.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import Foundation
import Shared

public protocol MemberUseCaseInterface {
    func sendMemberId(fcmToken: String, completion: @escaping (Result<String, APIError>) -> Void) async
}

public final class MemberUseCase: MemberUseCaseInterface {
    private let repository: MemberRepositoryInterface
    
    public init(repository: MemberRepositoryInterface) {
        self.repository = repository
    }
    
    public func sendMemberId(fcmToken: String, completion: @escaping (Result<String, Shared.APIError>) -> Void) async {
        await self.repository.sendMemberId(fcmToken: fcmToken, completion: completion)
    }
}
