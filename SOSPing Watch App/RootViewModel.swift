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
public class RootViewModel {
    var path: [Navigation] = []
    
    var sosViewModelInjection: SOSViewModel {
        let viewModel = SOSViewModel(locationUseCase: LocationUseCase(repository: LocationRepository()))
        viewModel.delegate = self
        return viewModel
    }
}

extension RootViewModel: SOSViewModelDelegate {
    public func sosButtonTapped() {
        path.append(.confirm)
    }
}

extension RootViewModel {
    enum Navigation: Hashable {
        case sos(SOSViewModel)
        case confirm
    }
}
