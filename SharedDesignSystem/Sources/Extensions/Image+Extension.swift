//
//  File.swift
//  
//
//  Created by 김도형 on 5/17/24.
//

import SwiftUI
import Foundation

public extension Image {
    init(_ sosFing: SOSFingImage) {
        self.init(sosFing.rawValue, bundle: .module)
    }
}
