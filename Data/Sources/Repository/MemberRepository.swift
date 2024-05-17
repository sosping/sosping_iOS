//
//  File.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import Foundation
import Domain
import Shared

public final class MemberRepository: MemberRepositoryInterface {
    private let networkManager = NetworkManager()
    
    public init() {}
    
    public func sendMemberId(fcmToken: String, completion: @escaping (Result<String, Shared.APIError>) -> Void) async {
        await self.networkManager.post(path: "/api/member/\(fcmToken)", body: Optional<String>.none , completion: completion)
    }
}
