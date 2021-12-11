//
//  Services.swift
//  NASA_Astronomy
//
//  Created by Manish on 11/12/21.
//

import Foundation
import Alamofire

protocol Servicable
{
    func fetchData<T:Decodable>(request:URLRequestConvertible,_ type:T.Type,_ completion:@escaping (Result<T?, NetworkError>)->Void)
}

final class Services : Servicable
{
    func fetchData<T:Decodable>(request:URLRequestConvertible,_ type:T.Type,_ completion:@escaping (Result<T?, NetworkError>)->Void)
    {
        AF.request(request).responseJSON { response in
            
            if let err = response.error {
                
                completion(.failure(NetworkError.failure(err)))
            }
            
            if let data = response.data {
                
                let obj = Parser.parseData(data, T.self)
                completion(.success(obj))
            }
        }
    }
}
