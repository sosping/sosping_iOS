//
//  File.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import Foundation
import Domain
import Shared

public final class BeachLocationRepository: BeachLocationRepositoryInterface {
    private let networkManager = NetworkManager.shared
    
    public init() {}
    
    public func fetchBeachLocations(name: String, completion: @escaping (Result<[Domain.BeachLocation], Shared.APIError>) -> Void) async {
        await self.networkManager.get(path: "/api/beach/locations/\(name)/beach", completion: completion)
    }
}
