//
//  File.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import SwiftUI
import Domain
import Shared

public protocol SOSViewModelDelegate {
    func sosButtonTapped()
}

public class SOSViewModel: NSObject {
    @ObservationIgnored private var locationUseCase: LocationUseCaseInterface?
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    public var delegate: (any SOSViewModelDelegate)?
    
    public init(locationUseCase: LocationUseCaseInterface? = nil) {
        super.init()
        self.locationUseCase = locationUseCase
        self.locationUseCase?.delegate = self
    }
    
    func sosButtonTapped() {
        Task {
            await self.locationUseCase?.sendLocation(latitude: self.latitude, longitude: self.longitude, completion: { [weak self] completion in
                guard let `self` else { return }
                switch completion {
                case .success(let success):
                    return
                case .failure(let failure):
                    return
                }
            })
            self.delegate?.sosButtonTapped()
        }
    }
}

extension SOSViewModel: LocationManagerDelegate {
    public func fetchLocation(latitude: Double, longitude: Double) {
        DispatchQueue.main.async {
            self.latitude = latitude
            self.longitude = longitude
        }
    }
}
