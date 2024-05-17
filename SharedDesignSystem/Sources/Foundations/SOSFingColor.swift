//
//  File.swift
//  
//
//  Created by 김도형 on 5/17/24.
//

import SwiftUI

public enum SOSFingColor: String {
    case sosfingBlue = "sosfing.blue"
    case sosfingRed = "sosfing.red"
    case sosfingGray1 = "sosfing.gray1"
    case sosfingGray2 = "sosfing.gray2"
    case sosfingGray3 = "sosfing.gray3"
    case sosfingText = "sosfing.text"
    
    public var color: Color {
        return .init(self.rawValue, bundle: .module)
    }
}
