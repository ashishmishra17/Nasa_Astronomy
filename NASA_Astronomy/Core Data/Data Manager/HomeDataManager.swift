//
//  HomeDataManager.swift
//  NASA_Astronomy
//
//  Created by Manish on 12/12/21.
//

import Foundation

class HomeDataManager {
    
    static let shared = HomeDataManager()
    
    private init() { }
    
    func getHomeData() -> HomeEntity? {
        
        // Fetch entities
        let entity = CoreDataManager.shared.fetchData()
        
        return entity as? HomeEntity
    }
    
    func saveHomeData() -> HomeEntity? {
        
        // Fetch entities
        let entity = CoreDataManager.shared.fetchData()
        
        return entity as? HomeEntity
    }
    
}
