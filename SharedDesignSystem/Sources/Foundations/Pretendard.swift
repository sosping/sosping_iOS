//
//  File.swift
//  
//
//  Created by 김도형 on 5/17/24.
//

import SwiftUI

public enum Pretendard: String, CaseIterable {
    case black = "Black"
    case bold = "Bold"
    case extraBold = "ExtraBold"
    case extraLight = "ExtraLight"
    case light = "Light"
    case medium = "Medium"
    case regular = "Regular"
    case semiBold = "SemiBold"
    case thin = "Thin"
    
    public func font(size: CGFloat) -> Font {
        return .custom("Pretendard-\(self.rawValue)", size: size)
    }
}
