//
//  SOSPingExtension.swift
//  SOSPingExtension
//
//  Created by 김도형 on 5/18/24.
//

import AppIntents

struct SOSPingExtension: AppIntent {
    static var title: LocalizedStringResource = "SOSPingExtension"
    
    func perform() async throws -> some IntentResult {
        return .result()
    }
}
