//
//  FavoriteViewController.swift
//  NASA_Astronomy
//
//  Created by Manish on 11/12/21.
//

import Foundation
import UIKit

class FavoriteViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView : UITableView?
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        setTableHandler()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.title = "Favorite"
    }
    
    func setTableHandler(){
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        print(homeData.)
        let cell:UITableViewCell = (self.tableView?.dequeueReusableCell(withIdentifier: cellReuseIdentifier))!
        
        cell.textLabel?.text = "12-11-2022"
        cell.accessoryType = .detailDisclosureButton

        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                            accessoryButtonTappedForRowWith indexPath: IndexPath) {
    }
}
