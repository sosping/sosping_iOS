//
//  File.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import Foundation

public struct BeachLocation: Codable {
    public let location: String
    public let beach: String
    
    public init(location: String, beach: String) {
        self.location = location
        self.beach = beach
    }
}
