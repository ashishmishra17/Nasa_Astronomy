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
        addHeartButton(cell: cell, indexPath1: indexPath)

        cell.selectionStyle = .none
        
        return cell
    }
    
    func addHeartButton(cell : UITableViewCell, indexPath1 : IndexPath){
        let btnHeart = UIButton()
        btnHeart.setImage(UIImage(named: "Empty_heart"), for: .normal)
        btnHeart.frame = CGRect(x: self.view.frame.size.width - 44, y: 5, width: 34, height: 34)
        btnHeart.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        btnHeart.tag = indexPath1.row
        cell.addSubview(btnHeart)
    }
    
    @objc func pressed(btnHeart : UIButton) {
        if (btnHeart.currentImage == UIImage(named: "Empty_heart")){
            btnHeart.setImage(UIImage(named: "Full_Heart"), for: .normal)
            
        }
        else{
            btnHeart.setImage(UIImage(named: "Empty_heart"), for: .normal)
           
        }
        
    }
}
