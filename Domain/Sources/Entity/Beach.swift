//
//  File.swift
//  
//
//  Created by 김도형 on 5/17/24.
//

import Foundation

public struct Beach: Codable {
    public let beachData: BeachData
    public let recommendationLevel: Level
    public let recommendationTime: String
    
    enum CodingKeys: String, CodingKey {
        case beachData, recommendationLevel, recommendationTime
    }
}

public extension Beach {
    enum Level: String, Codable {
        case good = "GOOD"
        case bad = "BAD"
        case veryGood = "VERY_GOOD"
    }
    
    struct BeachData: Codable, Identifiable {
        public let id: Int
        public let date: Date
        public let time: String
        public let windSpeed: Double
        public let temperature: Int
        public let skyStatus: String
        public let waveHeight: Double
        public let wavePeriod: Int
        public let tideHeight: Double
        public let tideTime: String?
        public let locationName, beachName: String
        
        enum CodingKeys: String, CodingKey {
            case id = "beachDataId"
            case temperature = "skyCode"
            case date, time, windSpeed, skyStatus, waveHeight, wavePeriod, tideHeight, tideTime, locationName, beachName
        }
    }
}
