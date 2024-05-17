//
//  File.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import Foundation
import Shared

public protocol LocationRepositoryInterface {
    var delegate: (any LocationManagerDelegate)? { get set }
    func sendLocation(latitude: Double, longitude: Double, completion: @escaping (Result<String, APIError>) -> Void) async
}
