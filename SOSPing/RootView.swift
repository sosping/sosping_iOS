//
//  ContentView.swift
//  SOSPing Watch App
//
//  Created by 김도형 on 5/17/24.
//

import SwiftUI
import Presentation
import Data
import Domain
import SharedDesignSystem

struct RootView: View {
    @State var viewModel: RootViewModel = .init()
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            HomeView(viewModel: viewModel.homeViewModelInjection)
                .navigationDestination(for: RootViewModel.Navigation.self) { path in
                    switch path {
                    case .home(let viewModel):
                        HomeView(viewModel: viewModel)
                    case .locationList(let viewModel):
                        LocationListView(viewModel: viewModel)
                    }
                }
        }
        .tint(.sosfingGray2)
    }
}

extension RootView {
    static var preview: RootView {
        Font.registerFont()
        
        return .init()
    }
}

#Preview {
    RootView.preview
}
