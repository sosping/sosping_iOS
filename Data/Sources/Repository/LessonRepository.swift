//
//  File.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import Foundation
import Domain
import Shared

public final class LessonRepository: LessonRepositoryInterface {
    private let networkManager = NetworkManager.shared
    
    public init() {}
    
    public func fetchLessons(date: String, completion: @escaping (Result<[Domain.Lesson], Shared.APIError>) -> Void) async {
        await self.networkManager.get(path: "/api/lesson/\(date)", completion: completion)
    }
}
