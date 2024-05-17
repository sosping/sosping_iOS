//
//  File.swift
//  
//
//  Created by 김도형 on 5/18/24.
//

import SwiftUI
import Domain

public protocol HomeViewModelDelegate: AnyObject {
    func notificationButtonTapped()
    func searchButtonTapped(searchText: String)
    func beachCellButtonTapped(name: String)
}

@Observable
public class HomeViewModel: NSObject {
    public var delegate: (any HomeViewModelDelegate)?
    
    var searchText: String = ""
    var dailyBeach: [Beach.BeachData] = []
    
    @ObservationIgnored private let beachUseCase: BeachUseCaseInterface?
    @ObservationIgnored private let loginUseCase: LoginUseCaseInterface?
    
    public init(beachUseCase: BeachUseCaseInterface? = nil,
                loginUseCase: LoginUseCaseInterface? = nil) {
        self.beachUseCase = beachUseCase
        self.loginUseCase = loginUseCase
    }
    
    func onAppeared() {
        Task {
            await self.fetchDailyBeach()
        }
    }
    
    func beachCellButtonTapped(name: String) {
        self.delegate?.beachCellButtonTapped(name: name)
    }
    
    private func fetchDailyBeach() async {
        await self.beachUseCase?.fetchDailyBeaches { [weak self] completion in
            guard let `self` else { return }
            
            switch completion {
            case .success(let beaches):
                withAnimation(.smooth) {
                    self.dailyBeach = beaches.map { $0.beachData }
                }
            case .failure(let failure):
                switch failure {
                case .token:
                    self.requestAccessToken()
                default:
                    return
                }
            }
        }
    }
    
    private func requestAccessToken() {
        Task {
            guard let success = await self.loginUseCase?.requestAccessToken(), success else {
                return
            }
        }
    }
}
