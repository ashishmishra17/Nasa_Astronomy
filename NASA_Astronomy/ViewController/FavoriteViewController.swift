//
//  FavoriteViewController.swift
//  NASA_Astronomy
//
//  Created by Manish on 11/12/21.
//

import Foundation
import UIKit

class FavoriteViewController : UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.title = "Favorite"
    }
}
