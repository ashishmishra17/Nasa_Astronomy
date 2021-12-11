//
//  HomeViewModel.swift
//  NASA_Astronomy
//
//  Created by Manish on 11/12/21.
//

import Foundation

class HomeViewModel
{
    private var service:Servicable?
    
    init(_ service:Servicable)
    {
        self.service = service
    }
    
    func fetchNasaData()
    {
        guard let service = service else {
            return
        }
 
        let homeRuter = HomeRouter([:])
        service.fetchData(request: homeRuter, HomeEntity.self) { result in
            
            switch result
            {
            case .success(let homeEntiy):
                print(homeEntiy)
                break
            case .failure(let error):
                print(error)
                break
            }
            
            print(homeRuter)
        }
        
    }
}
