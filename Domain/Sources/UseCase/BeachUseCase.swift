//
//  File.swift
//  
//
//  Created by 김도형 on 5/17/24.
//

import Foundation
import Shared

public protocol BeachUseCaseInterface {
    init(repository: BeachRepositoryInterface)
    func fetchDailyBeaches(completion: @escaping (Result<[Beach], APIError>) -> Void) async
}

public final class BeachUseCase: BeachUseCaseInterface {
    private let repository: BeachRepositoryInterface
    
    public init(repository: BeachRepositoryInterface) {
        self.repository = repository
    }
    
    public func fetchDailyBeaches(completion: @escaping (Result<[Beach], Shared.APIError>) -> Void) async {
        await repository.fetchDailyBeaches(completion: completion)
    }
}
