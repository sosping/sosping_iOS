//
//  SwiftUIView.swift
//  
//
//  Created by 김도형 on 5/17/24.
//

import SwiftUI
import Domain
import SharedDesignSystem

public struct HomeView: View {
    @State private var viewModel: HomeViewModel
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                title
                
                searchBar
                    .padding(.top, 32)
                    .padding(.horizontal, 32)
                
                dailyBeach
                    .padding(.top, 40)
                    .padding(.horizontal, 32)
                
                Spacer(minLength: 150)
            }
        }
        .ignoresSafeArea()
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("SOSPING")
                    .font(.helveticaBold(size: 18))
                    .foregroundStyle(.white.opacity(0.5))
                    .padding(.leading, 16)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                notificationButton
                    .padding(.trailing, 16)
            }
        }
        .onAppear {
            viewModel.onAppeared()
        }
    }
    
    private var title: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("오늘은\n양양 인구해변\n어때요?")
                .font(.pretendard(weight: .bold, size: 36))
                .foregroundStyle(.white)
                .lineSpacing(4)
            
            Text("오후 3시에 서핑하기 가장 좋아요")
                .font(.pretendard(weight: .medium, size: 16))
                .foregroundStyle(.white)
                .padding(.top, 8)
            
            Spacer()
            
            HStack {
                Spacer()
                
                reservationButton
                    .padding(.bottom, 40)
            }
        }
        .padding(.horizontal, 32)
        .padding(.top, 125)
        .background {
            VStack {
                Image(.home)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                Spacer()
            }
        }
        .frame(height: 596)
    }
    
    private var reservationButton: some View {
        Button {
            
        } label: {
            Text("바로 예약하기")
                .font(.pretendard(weight: .medium, size: 18))
                .foregroundStyle(.sosfingText)
                .padding(.vertical, 18)
                .padding(.horizontal, 32)
                .background {
                    RoundedRectangle(cornerRadius: 30, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.white)
                }
        }
    }
    
    private var notificationButton: some View {
        Button {
            
        } label: {
            Image(systemName: "bell")
                .foregroundStyle(.white)
        }
    }
    
    private var searchBar: some View {
        HStack(spacing: 4) {
            TextField("어디서 서핑할까요?", text: $viewModel.searchText)
                .font(.pretendard(weight: .bold, size: 24))
                .foregroundStyle(.sosfingText)
                .padding(.bottom, 8)
                .background(alignment: .bottom) {
                    Rectangle()
                        .fill(.sosfingGray1)
                        .frame(height: 1)
                }
            
            Button {
                
            } label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.sosfingGray2)
                    .padding(4)
            }
        }
    }
    
    private var dailyBeach: some View {
        VStack(spacing: 16) {
            HStack {
                Text("오늘의 추천 서핑지")
                    .font(.pretendard(weight: .semiBold, size: 18))
                    .foregroundStyle(.sosfingText)
                
                Spacer()
                
                Button {
                    
                } label: {
                    HStack(spacing: 4) {
                        Text("전체보기")
                            .font(.pretendard(weight: .medium, size: 12))
                        
                        Image(systemName: "chevron.forward")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 12, height: 12)
                    }
                    .foregroundStyle(.sosfingGray2)
                }
            }
            
            if viewModel.dailyBeach.isEmpty {
                ProgressView()
                    .progressViewStyle(.circular)
                    .controlSize(.extraLarge)
            } else {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 8) {
                        ForEach(viewModel.dailyBeach) { beach in
                            beachCellButton(beach: beach)
                        }
                    }
                }
                .transition(.move(edge: .trailing).combined(with: .blurReplace).combined(with: .opacity))
            }
        }
    }
    
    @ViewBuilder
    private func beachCellButton(beach: Beach.BeachData) -> some View {
        Button {
            viewModel.beachCellButtonTapped(name: beach.locationName)
        } label: {
            VStack(alignment: .leading) {
                Spacer()
                
                Text(beach.locationName)
                    .font(.pretendard(weight: .medium, size: 16))
                    .foregroundStyle(.white.opacity(0.8))
                
                Text(beach.beachName)
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
            .frame(width: 160, height: 226)
        }
    }
}

extension HomeView {
    static var preview: HomeView {
        Font.registerFont()
        
        return .init(viewModel: .init())
    }
}

#Preview {
    NavigationStack {
        HomeView.preview
    }
}
