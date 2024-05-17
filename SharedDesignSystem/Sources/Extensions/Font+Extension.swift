//
//  File.swift
//  
//
//  Created by 김도형 on 5/17/24.
//

import SwiftUI

public extension Font {
    static func registerFont() {
        Pretendard.allCases.forEach { weight in
            guard let fontURL = Bundle.module.url(forResource: "Pretendard-\(weight.rawValue)", withExtension: ".otf"),
                  let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
                  let font = CGFont(fontDataProvider) else {
                return
            }
            
            CTFontManagerRegisterGraphicsFont(font, nil)
        }
        
        guard let fontURL = Bundle.module.url(forResource: "Helvetica-Bold", withExtension: ".ttf"),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            return
        }
        
        CTFontManagerRegisterGraphicsFont(font, nil)
    }
    
    static func pretendard(weight pretendard: Pretendard, size: CGFloat) -> Font {
        return pretendard.font(size: size)
    }
    
    static func helveticaBold(size: CGFloat) -> Font {
        return .custom("Helvetica-Bold", size: size)
    }
}
