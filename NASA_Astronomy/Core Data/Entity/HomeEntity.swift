//
//  HomeEntity.swift
//  NASA_Astronomy
//
//  Created by Manish on 12/12/21.
//

import Foundation
import CoreData

class HomeEntity: NSManagedObject {
    @NSManaged public var copyright : String?
    @NSManaged public var date : String?
    @NSManaged public var explanation : String?
}
