//
//  ErrorEnums.swift
//  NASA_Astronomy
//
//  Created by Manish on 12/12/21.
//

import Foundation

enum APIErrors: LocalizedError {
    
    case connectivityError
    
    var value: String {
        switch self {
            case .connectivityError: return "No Internet"
        }
    }
}
