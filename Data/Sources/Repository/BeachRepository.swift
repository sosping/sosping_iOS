//
//  File.swift
//  
//
//  Created by 김도형 on 5/17/24.
//

import Foundation
import Domain
import Shared

public final class BeachRepository: BeachRepositoryInterface {
    private let networkManager = NetworkManager.shared
    
    public init() {}
    
    public func fetchDailyBeaches(completion: @escaping (Result<[Beach], APIError>) -> Void) async {
        await networkManager.get(path: "/api/beach/recommendation/now", completion: completion)
    }
}
