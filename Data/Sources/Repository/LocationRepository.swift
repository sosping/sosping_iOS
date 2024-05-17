//
//  File.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import Foundation
import Domain
import Shared

public final class LocationRepository: LocationRepositoryInterface {
    private let locationManager = LocationManager()
    private let networkManager = NetworkManager.shared
    
    public init() {}
    
    public weak var delegate: (any LocationManagerDelegate)? {
        get { locationManager.delegate }
        set { locationManager.delegate = newValue }
    }
    
    public func sendLocation(latitude: Double, longitude: Double, completion: @escaping (Result<String, APIError>) -> Void) async {
        var result = ""
        await self.networkManager.post(path: "/api/help/location?latitude=\(latitude)&longitude=\(longitude)", body: Optional<String>.none, completion: completion)
    }
}
