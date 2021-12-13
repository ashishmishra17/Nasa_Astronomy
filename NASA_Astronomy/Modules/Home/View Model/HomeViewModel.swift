//
//  HomeViewModel.swift
//  NASA_Astronomy
//
//  Created by Manish on 11/12/21.
//

import Foundation

class HomeViewModel {
    private var service:Servicable?
    var successHandler: ((_ response: HomeModel?, _ error: Error?) -> ())?
    
    init(_ service:Servicable) {
        self.service = service
    }
    
    func fetchNasaData() {
        //Fetch from core data
        if let data = HomeDataManager.shared.getHomeData() {
            //self.successHandler?(data, nil)
            return
        }
        
        
        guard let service = service else {
            return
        }
 
        let homeRuter = HomeRouter([:])
        service.fetchData(request: homeRuter, HomeModel.self) { [weak self] result in
            
            switch result
            {
            case .success(let homeEntiy):
                print(homeEntiy)
                self?.successHandler?(homeEntiy, nil)
                break
            case .failure(let error):
                print(error)
                self?.successHandler?(nil, error)
                break
            }
            
            print(homeRuter)
        }
        
    }
    
    func saveNasaDataInCache(_ homeData: HomeModel?) {
        guard let homeData = homeData else {return}
        let cache = NSCache<AnyObject, AnyObject>()
        cache.setObject(homeData as AnyObject, forKey: "HomeScreenData" as AnyObject)
    }
    
    func fetchNasaDataFromCache() {
        let cache = NSCache<AnyObject, AnyObject>()
        if let homeData = cache.object(forKey: "HomeScreenData" as AnyObject) {
            self.successHandler?(homeData as? HomeModel, nil)
        }
    }
    
}
