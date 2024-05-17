//
//  SwiftUIView.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import SwiftUI
import Domain
import SharedDesignSystem

public struct LocationListView: View {
    private let viewModel: LocationListViewModel
    
    public init(viewModel: LocationListViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ScrollView {
            if viewModel.beachLocations.isEmpty {
                HStack {
                    Spacer()
                    
                    ProgressView()
                        .progressViewStyle(.circular)
                        .controlSize(.extraLarge)
                    
                    Spacer()
                }
            } else {
                list
                    .padding(.leading, 24)
                    .padding(.top, 44)
                    .transition(.move(edge: .bottom).combined(with: .blurReplace))
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text(viewModel.location)
                    .font(.pretendard(weight: .bold, size: 24))
                    .foregroundStyle(.sosfingText)
            }
        }
        .onAppear {
            viewModel.onAppeared()
        }
    }
    
    public var list: some View {
        LazyVStack(spacing: 16) {
            ForEach(viewModel.beachLocations, id: \.beach) { location in
                locationCellButton(location: location)
            }
        }
    }
    
    @ViewBuilder
    public func locationCellButton(location: BeachLocation) -> some View {
        Button {
            
        } label: {
            VStack(alignment: .leading, spacing: 4) {
                Spacer()
                
                Text(location.location)
                    .font(.pretendard(weight: .medium, size: 16))
                    .foregroundStyle(.white.opacity(0.8))
                
                Text(location.beach)
                    .font(.pretendard(weight: .bold, size: 20))
                    .foregroundStyle(.white)
                
                HStack {
                    Spacer()
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
            .background {
                Image(SOSFingImage.allCases.randomElement()!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .clipped()
            .frame(width: 369, height: 152)
        }
    }
}

extension LocationListView {
    static var preview: LocationListView {
        Font.registerFont()
        
        return .init(viewModel: .init(location: "양양"))
    }
}

#Preview {
    NavigationStack {
        LocationListView.preview
    }
}
