//
//  HomeViewController.swift
//  NASA_Astronomy
//
//  Created by Manish on 11/12/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var tableView : UITableView?
    
    var viewModel:HomeViewModel?
    var homeData: HomeEntity?
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        fetchData()
        viewModelHandler()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigationBar()
    }
    
    private func viewModelHandler() {
        viewModel?.successHandler = { (response, error) in
            if let error = error {
                print(error)
            }
            
            if let data = response {
                print(data.title ?? "")
            }
            
        }
    }
    
    func initViewModel() {
        let service = Services()
        self.viewModel = HomeViewModel(service)
    }

    func fetchData() {
        self.viewModel?.fetchNasaData()
    }
    
    func setNavigationBar() {
        self.parent?.title = "Nasa's today's image"
    }

    @IBAction func search_action(sender : UIButton) {
        
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        print(homeData.)
        let cell:UITableViewCell = (self.tableView?.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UITableViewCell?)!
        
        // set the text from the data model
        //    cell.textLabel?.text =
        
        return cell
    }
    
}
