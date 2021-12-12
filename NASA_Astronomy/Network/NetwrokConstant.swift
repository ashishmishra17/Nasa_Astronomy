//
//  NetwrokConstant.swift
//  NASA_Astronomy
//
//  Created by Manish on 11/12/21.
//

import Foundation

struct NetworkConstant
{
    static let baseUrl = "https://api.nasa.gov"
    static let Api_key = "YQR4wTvcQjvvyB99U2miPYgLTpSZhTIjeoGVe4Qc"
    
    enum HTTPHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    enum ContentType: String {
        case json = "application/json"
    }
}

enum NetworkError : Error {
    case success(String)
    case failure(Error)
}
