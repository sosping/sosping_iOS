//
//  File.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import Foundation
import Shared

public protocol TutorRepositoryInterface {
    func fetchTutorCareer(name: String, completion: @escaping (Result<[String], APIError>) -> Void) async
}
