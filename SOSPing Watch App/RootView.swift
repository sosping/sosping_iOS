//
//  RootView.swift
//  SOSPing Watch App
//
//  Created by 김도형 on 5/18/24.
//

import SwiftUI
import Data
import Presentation
import Domain
import SharedDesignSystem

struct RootView: View {
    @State private var viewModel = RootViewModel()
    
    init() {
        Font.registerFont()
    }
    
    var body: some View {
        NavigationStack(path: $viewModel.path) { 
            SOSView(viewModel: viewModel.sosViewModelInjection)
                .navigationDestination(for: RootViewModel.Navigation.self) { path in
                    switch path {
                    case .sos(let viewModel):
                        SOSView(viewModel: viewModel)
                    case .confirm:
                        ConfirmView() 
                    }
                }
        }
    }
}

#Preview {
    RootView()
}
