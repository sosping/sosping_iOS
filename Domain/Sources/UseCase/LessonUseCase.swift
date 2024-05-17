//
//  File.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import Foundation
import Shared

public protocol LessonUseCaseInterface {
    func fetchBeachLocations(date: String, completion: @escaping (Result<[Lesson], APIError>) -> Void) async
}

public final class LessonUseCase: LessonUseCaseInterface {
    private let repository: LessonRepositoryInterface
    
    public init(repository: LessonRepositoryInterface) {
        self.repository = repository
    }
    
    public func fetchBeachLocations(date: String, completion: @escaping (Result<[Lesson], Shared.APIError>) -> Void) async {
        await self.repository.fetchLessons(date: date, completion: completion)
    }
}
