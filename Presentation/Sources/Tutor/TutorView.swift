//
//  SwiftUIView.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import SwiftUI
import SharedDesignSystem

public struct TutorView: View {
    @State private var viewModel: TutorViewModel
    
    public init(viewModel: TutorViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            profile
            
            lesson
                .padding(.horizontal, 24)
                .padding(.top, 26)
            
            Spacer(minLength: 40)
        }
        .background {
            Color.white
        }
        .ignoresSafeArea()
    }
    
    private var profile: some View {
        VStack(spacing: 4) {
            HStack {
                Text("\(viewModel.lesson.tutorName) 강사")
                    .font(.pretendard(weight: .bold, size: 30))
                
                Spacer()
            }
             
            Spacer()
            
            ForEach(viewModel.carear, id: \.hashValue) { career in
                Text(career)
                    .font(.pretendard(weight: .medium, size: 14))
            }
        }
        .foregroundStyle(.white)
        .padding(.vertical, 32)
        .padding(.horizontal, 24)
        .background {
            Image(SOSFingImage.allCases.suffix(6).randomElement()!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 244)
                .clipped()
                .overlay {
                    LinearGradient(gradient: Gradient(colors: [.black, Color(red: 0, green: 0, blue: 0).opacity(0)]), startPoint: .bottom, endPoint: .top)
                }
        }
    }
    
    private var lesson: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("수업 일정")
                .font(.pretendard(weight: .semiBold, size: 18))
                .foregroundStyle(.sosfingText)
                .padding(.bottom, 16)
            
            HStack {
                Text(viewModel.lesson.lessonResponse.localDate, style: .date)
                    .font(.pretendard(weight: .semiBold, size: 18)) +
                Text(" \(viewModel.lesson.lessonResponse.localTime) (2시간)")
                    .font(.pretendard(weight: .semiBold, size: 18))
                
                Spacer()
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 24)
            .background {
                Color.sosfingGray3
            }
            .padding(.bottom, 16)
            
            Text("환불은 전일 00:00시 까지만 가능합니다.")
                .font(.pretendard(weight: .regular, size: 14))
                .foregroundStyle(.sosfingGray2)
                .padding(.bottom, 30)
            
            reservationButton
        }
    }
    
    private var reservationButton: some View {
        Button {
            
        } label: {
            Text("예약하기")
                .font(.pretendard(weight: .medium, size: 18))
                .foregroundStyle(.white)
                .padding(.horizontal, 132)
                .padding(.vertical, 20)
                .background {
                    RoundedRectangle(cornerRadius: 32, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                        .fill(.sosfingBlue)
                }
        }
    }
}

extension TutorView {
    static var preview: TutorView {
        Font.registerFont()
        
        return .init(
            viewModel: .init(
                lesson: .init(
                    lessonResponse: .init(
                        lessonId: 1,
                        maxCount: 20,
                        count: 3,
                        localDate: .now,
                        localTime: "10:00:00",
                        isFull: false,
                        tutorId: 1),
                    tutorName: "김정래")))
    }
}

#Preview {
    TutorView.preview
}
