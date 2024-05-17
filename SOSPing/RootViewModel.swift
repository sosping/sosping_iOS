//
//  RootViewModel.swift
//  SOSPing Watch App
//
//  Created by 김도형 on 5/18/24.
//

import SwiftUI
import Presentation
import Data
import Domain

@Observable
final class RootViewModel {
    var path: [Navigation] = []
    
    var homeViewModelInjection: HomeViewModel {
        let beachRepository = BeachRepository()
        let loginRepository = LoginRepository()
        let beachUseCase = BeachUseCase(repository: beachRepository)
        let loginUseCase = LoginUseCase(repository: loginRepository)
        let viewModel = HomeViewModel(beachUseCase: beachUseCase, loginUseCase: loginUseCase)
        viewModel.delegate = self
        
        return viewModel
    }
    
    func locationListViewInjection(name: String) -> LocationListViewModel {
        let beachLocationRepository = BeachLocationRepository()
        let loginRepository = LoginRepository()
        let beachLocationUseCase = BeachLocationUseCase(repository: beachLocationRepository)
        let loginUseCase = LoginUseCase(repository: loginRepository)
        let viewModel = LocationListViewModel(location: name, beachLocationUseCase: beachLocationUseCase, loginUseCase: loginUseCase)
        viewModel.delegate = self
        
        return viewModel
    }
}

extension RootViewModel: HomeViewModelDelegate {
    func beachCellButtonTapped(name: String) {
        let viewModel = self.locationListViewInjection(name: name)
        self.path.append(.locationList(viewModel))
    }
    
    func notificationButtonTapped() {
        
    }
    
    func searchButtonTapped(searchText: String) {
        
    }
}

extension RootViewModel: LocationListViewModelDelegate {
    func locationCellButtonTapped(name: String) {
        
    }
}

extension RootViewModel {
    enum Navigation: Hashable {
        case home(HomeViewModel)
        case locationList(LocationListViewModel)
    }
}
