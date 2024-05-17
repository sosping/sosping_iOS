//
//  File.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import Foundation

public struct Lesson: Codable {
    public let lessonResponse: Response
    public let tutorName: String
    
    public init(lessonResponse: Response, tutorName: String) {
        self.lessonResponse = lessonResponse
        self.tutorName = tutorName
    }
}

public extension Lesson {
    struct Response: Codable {
        public let lessonId, maxCount, count: Int
        public let localDate: Date
        public let localTime: String
        public let isFull: Bool
        public let tutorId: Int
        
        public init(
            lessonId: Int,
            maxCount: Int,
            count: Int,
            localDate: Date,
            localTime: String,
            isFull: Bool,
            tutorId: Int) {
            self.lessonId = lessonId
            self.maxCount = maxCount
            self.count = count
            self.localDate = localDate
            self.localTime = localTime
            self.isFull = isFull
            self.tutorId = tutorId
        }
        
        public enum CodingKeys: String, CodingKey {
            case lessonId
            case maxCount, count, localDate, localTime, isFull
            case tutorId
        }
    }
}
