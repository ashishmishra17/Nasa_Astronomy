//
//  NetworkConnectivity.swift
//  NASA_Astronomy
//
//  Created by Manish on 12/12/21.
//

import Foundation
import Alamofire

class Connectivity {
    
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
}
