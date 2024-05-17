//
//  File.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import Foundation
import Shared

public protocol BeachLocationRepositoryInterface {
    func fetchBeachLocations(name: String, completion: @escaping (Result<[BeachLocation], APIError>) -> Void) async
}
