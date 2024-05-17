//
//  SwiftUIView.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import SwiftUI

public struct ConfirmView: View {
    @Environment(\.dismiss) var dismiss
    
    public init() {}
    
    public var body: some View {
        VStack {
            title
            
            Spacer()
            
            confirmButton
        }
    }
    
    private var title: some View {
        HStack {
            Text("위급상황을\n주변에 알렸습니다.")
                .font(.pretendard(weight: .bold, size: 18))
                .foregroundStyle(.white)
            
            Spacer()
        }
    }
    
    private var confirmButton: some View {
        Button {
            dismiss()
        } label: {
            Text("상황종료")
                .padding(.vertical, 20)
                .padding(.horizontal, 40)
                .background {
                    RoundedRectangle(cornerRadius: 32, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                        .fill(.sosfingBlue)
                }
        }
    }
}

#Preview {
    ConfirmView()
}
