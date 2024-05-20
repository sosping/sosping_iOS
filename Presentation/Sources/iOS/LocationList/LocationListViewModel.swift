//
//  File.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import SwiftUI
import Domain

public protocol LocationListViewModelDelegate: AnyObject {
    func locationCellButtonTapped(beachLocation: BeachLocation)
}

@Observable
public class LocationListViewModel: NSObject {
    public weak var delegate: (any LocationListViewModelDelegate)?
    
    let location: String
    var beachLocations: [BeachLocation] = []
    
    @ObservationIgnored let beachLocationUseCase: BeachLocationUseCaseInterface?
    @ObservationIgnored private let loginUseCase: LoginUseCaseInterface?
    
    public init(location: String, 
                beachLocationUseCase: BeachLocationUseCaseInterface? = nil,
                loginUseCase: LoginUseCaseInterface? = nil) {
        self.location = location
        self.beachLocationUseCase = beachLocationUseCase
        self.loginUseCase = loginUseCase
    }
    
    func onAppeared() {
        Task {
            await fetchBeachLocations()
        }
    }
    
    func locationCellButtonTapped(beachLocation: BeachLocation) {
        self.delegate?.locationCellButtonTapped(beachLocation: beachLocation)
    }
    
    func fetchBeachLocations() async {
        await self.beachLocationUseCase?.fetchBeachLocations(name: self.location) { [weak self] completion in
            guard let `self` else  { return }
            
            switch completion {
            case .success(let success):
                withAnimation(.smooth) {
                    self.beachLocations = success
                }
            case .failure(let failure):
                switch failure {
                case .token:
                    self.requestAccessToken()
                default:
                    return
                }
            }
        }
    }
    
    private func requestAccessToken() {
        Task {
            guard let success = await self.loginUseCase?.requestAccessToken(), success else {
                return
            }
        }
    }
}
