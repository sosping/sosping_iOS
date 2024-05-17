//
//  File.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import Foundation
import Shared

public protocol LessonRepositoryInterface {
    func fetchLessons(date: String, completion: @escaping (Result<[Lesson], APIError>) -> Void) async
}
