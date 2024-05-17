//
//  File.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import Foundation

public protocol LocationManagerDelegate: AnyObject {
    func fetchLocation(latitude: Double, longitude: Double)
}
