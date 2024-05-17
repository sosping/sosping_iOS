//
//  File.swift
//  
//
//  Created by 김도형 on 5/17/24.
//

import Foundation

public enum APIError: Error {
    case unknown
    case json
    case code400
    case token
    case response(code: Int)
    
    public static func convert(error: Error) -> APIError {
        switch error {
        case is APIError:
            debugPrint("\(#function): error = \(error)")
            return error as! APIError
        case is DecodingError:
            debugPrint("\(#function): error = \(APIError.json)")
            return .json
        case is EncodingError:
            debugPrint("\(#function): error = \(APIError.json)")
            return .json
        default:
            debugPrint("\(#function): error = \(APIError.unknown)")
            return .unknown
        }
    }
}
