//
//  SwiftUIView.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import SwiftUI
import Domain
import SharedDesignSystem

public struct LessonReservationView: View {
    @State private var viewModel: LessonReservationViewModel
    
    public init(viewModel: LessonReservationViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                title
                
                calendar
                    .padding(.horizontal, 24)
                
                tutorList
            }
        }
        .ignoresSafeArea()
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("수업예약")
                    .font(.pretendard(weight: .medium, size: 16))
                    .foregroundStyle(.white)
                    .padding(.leading, 16)
            }
        }
        .onAppear {
            viewModel.onAppeared()
        }
        .onChange(of: viewModel.selectedDate) { oldValue, newValue in
            viewModel.selectedDateOnChanged(date: newValue)
        }
    }
    
    private var title: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("오늘의\n\(viewModel.beachLocation.location) \(viewModel.beachLocation.beach)은")
                    .font(.pretendard(weight: .bold, size: 36))
                    .foregroundStyle(.white)
                    .lineSpacing(4)
                
                Spacer()
                
                weatherDetailButton
            }
            
            Spacer()
        }
        .padding(.horizontal, 32)
        .padding(.top, 125)
        .background {
            VStack {
                Image(.home)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay {
                        Color.black.opacity(0.3)
                    }
                    .blur(radius: 4)
                
                Spacer()
            }
        }
        .frame(height: 439)
    }
    
    private var weatherDetailButton: some View {
        Button {
            
        } label: {
            Image(systemName: "chevron.forward")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 22, height: 22)
                .foregroundStyle(.white)
        }
    }
    
    private var calendar: some View {
        DatePicker("날짜", selection: $viewModel.selectedDate, in: Date()..., displayedComponents: .date)
        #if os(iOS)
            .datePickerStyle(.graphical)
        #endif
            .tint(.sosfingBlue)
    }
    
    @ViewBuilder
    private func tutorCell(lesson: Lesson) -> some View {
        Button {
            viewModel.tutorCellButtonTapped(lesson: lesson)
        } label: {
            VStack {
                HStack(spacing: 8) {
                    Circle()
                        .fill(.sosfingBlue)
                        .frame(width: 12, height: 12)
                    
                    Text("\(lesson.lessonResponse.localTime) (2시간)")
                        .font(.pretendard(weight: .medium, size: 16))
                        .foregroundStyle(.sosfingText)
                    
                    Spacer()
                    
                    if lesson.lessonResponse.isFull {
                        Text("마감")
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                                    .stroke(lineWidth: 1.0)
                            }
                            .foregroundStyle(.sosfingGray2)
                    }
                }
                
                HStack(spacing: 0) {
                    Image(SOSFingImage.allCases.suffix(6).randomElement()!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 94)
                        .clipped()
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Group {
                                Text(lesson.tutorName)
                                    .foregroundStyle(.sosfingBlue) +
                                Text("강사")
                                    .foregroundStyle(.sosfingText)
                            }
                            .font(.pretendard(weight: .medium, size: 16))
                            
                            Spacer()
                        }
                        .padding(.bottom, 16)
                        
                        Rectangle()
                            .fill(.sosfingGray2)
                            .frame(height: 1)
                            .padding(.bottom, 8)
                        
                        Text("수강인원 | \(lesson.lessonResponse.count)/\(lesson.lessonResponse.maxCount)인")
                            .font(.pretendard(weight: .regular, size: 14))
                            .foregroundStyle(.sosfingGray2)
                    }
                    .padding(.vertical, 18)
                    .padding(.horizontal, 16)
                }
                .background {
                    Color.white
                }
            }
        }
    }
    
    private var tutorList: some View {
        LazyVStack(spacing: 32) {
            if viewModel.lessons.isEmpty {
                HStack {
                    Spacer()
                    
                    ProgressView()
                        .progressViewStyle(.circular)
                        .controlSize(.extraLarge)
                    
                    Spacer()
                }
            } else {
                ForEach(viewModel.lessons, id: \.lessonResponse.lessonId) { lesson in
                    tutorCell(lesson: lesson)
                }
                .transition(.move(edge: .bottom).combined(with: .blurReplace).combined(with: .opacity))
            }
            
            Spacer(minLength: 150)
        }
        .padding([.top, .horizontal], 32)
        .background {
            Color.sosfingGray3
                .ignoresSafeArea()
        }
    }
}

extension LessonReservationView {
    static var preview: LessonReservationView {
        Font.registerFont()
        
        return .init(viewModel: .init(beachLocation: .init(location: "양양", beach: "인구해변")))
    }
}

#Preview {
    NavigationStack {
        LessonReservationView.preview
    }
}
