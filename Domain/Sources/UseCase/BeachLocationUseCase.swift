//
//  File.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import Foundation
import Shared

public protocol BeachLocationUseCaseInterface {
    func fetchBeachLocations(name: String, completion: @escaping (Result<[BeachLocation], APIError>) -> Void) async
}

public final class BeachLocationUseCase: BeachLocationUseCaseInterface {
    private let repository: BeachLocationRepositoryInterface
    
    public init(repository: BeachLocationRepositoryInterface) {
        self.repository = repository
    }
    
    public func fetchBeachLocations(name: String, completion: @escaping (Result<[BeachLocation], APIError>) -> Void) async {
        await self.repository.fetchBeachLocations(name: name, completion: completion)
    }
}
