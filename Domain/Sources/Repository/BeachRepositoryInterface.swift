//
//  File.swift
//  
//
//  Created by 김도형 on 5/17/24.
//

import Foundation
import Shared

public protocol BeachRepositoryInterface {
    init()
    func fetchDailyBeaches(completion: @escaping (Result<[Beach], APIError>) -> Void) async
}
