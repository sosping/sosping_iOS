//
//  SwiftUIView.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import SwiftUI
import SharedDesignSystem

public struct SOSView: View {
    @State private var viewModel: SOSViewModel
    
    public init(viewModel: SOSViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        sosButton
    }
    
    private var sosButton: some View {
        Button {
            viewModel.sosButtonTapped()
        } label: {
            ZStack {
                Circle()
                    .fill(.sosfingRed2)
                
                Text("SOSPING")
                    .font(.helveticaBold(size: 22))
                    .foregroundStyle(.white)
            }
            .frame(width: 118, height: 118)
        }
    }
}

extension SOSView {
    static var preview: SOSView {
        Font.registerFont()
        
        return .init(viewModel: .init())
    }
}

#Preview {
    SOSView.preview
}
