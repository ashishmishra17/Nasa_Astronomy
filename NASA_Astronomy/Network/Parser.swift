//
//  Parser.swift
//  NASA_Astronomy
//
//  Created by Manish on 11/12/21.
//

import Foundation

struct Parser
{
    static func parseData<T:Decodable>(_ data:Data,_ type:T.Type) -> T?
    {
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type.self, from: data)
            return object
        } catch  {
            return nil
        }
    }
}
