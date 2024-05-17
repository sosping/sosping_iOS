//
//  File.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import Foundation
import Domain
import Shared

public final class TutorRepository: TutorRepositoryInterface {
    private let networkManager = NetworkManager.shared
    
    public init() {}
    
    public func fetchTutorCareer(name: String, completion: @escaping (Result<[String], Shared.APIError>) -> Void) async {
        await self.networkManager.get(path: "/api/member/\(name)/experience", completion: completion)
    }
}
