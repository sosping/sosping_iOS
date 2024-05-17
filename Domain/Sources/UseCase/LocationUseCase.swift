//
//  File.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import Foundation
import Shared

public protocol LocationUseCaseInterface {
    var delegate: (any LocationManagerDelegate)? { get set }
    func sendLocation(latitude: Double, longitude: Double, completion: @escaping (Result<String, APIError>) -> Void) async
}

public final class LocationUseCase: LocationUseCaseInterface {
    private var repository: LocationRepositoryInterface
    
    public weak var delegate: (any LocationManagerDelegate)? {
        get { self.repository.delegate }
        set { self.repository.delegate = newValue }
    }
    
    public init(repository: LocationRepositoryInterface) {
        self.repository = repository
    }
    
    public func sendLocation(latitude: Double, longitude: Double, completion: @escaping (Result<String, Shared.APIError>) -> Void) async {
        await self.repository.sendLocation(latitude: latitude, longitude: longitude, completion: completion)
    }
    
}
