//
//  File.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import Foundation
import Shared

public protocol TutorUseCaseInterface {
    func fetchTutorCareer(name: String, completion: @escaping (Result<[String], APIError>) -> Void) async
}

public final class TutorUseCase: TutorUseCaseInterface {
    private let repository: TutorRepositoryInterface
    
    public init(repository: TutorRepositoryInterface) {
        self.repository = repository
    }
    
    public func fetchTutorCareer(name: String, completion: @escaping (Result<[String], Shared.APIError>) -> Void) async {
        await self.repository.fetchTutorCareer(name: name, completion: completion)
    }
}
