//
//  NetworkRouter.swift
//  NASA_Astronomy
//
//  Created by Manish on 11/12/21.
//

import Foundation
import Alamofire

struct HomeRouter : URLRequestConvertible
{
    private var parameters: Parameters?
    
    init(_ parameters:[String:Any])
    {
        self.parameters = parameters
    }
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        return .get
    }
    
    // MARK: - Path
    private var path: String {
        return "/planetary/apod"
    }
    
    
    func asURLRequest() throws -> URLRequest {
        
        let queryItems = [URLQueryItem(name: "api_key", value: NetworkConstant.Api_key),]
        var urlComps = URLComponents(string: NetworkConstant.baseUrl + path)!
        urlComps.queryItems = queryItems
        let url = try urlComps.url
        
      //  let url = try NetworkConstant.baseUrl.asURL()
    
        var urlRequest = URLRequest(url: url!)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(NetworkConstant.ContentType.json.rawValue, forHTTPHeaderField: NetworkConstant.HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(NetworkConstant.ContentType.json.rawValue, forHTTPHeaderField: NetworkConstant.HTTPHeaderField.contentType.rawValue)
        
        
        
        // Parameters
        if let parameters = parameters {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
    
 

}
