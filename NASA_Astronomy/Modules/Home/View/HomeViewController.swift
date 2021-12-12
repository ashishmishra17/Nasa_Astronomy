//
//  HomeViewController.swift
//  NASA_Astronomy
//
//  Created by Manish on 11/12/21.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    
    @IBOutlet var tableView : UITableView?
    
    var viewModel:HomeViewModel?
    var homeData: HomeModel?
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        fetchData()
        setTableHandler()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigationBar()
    }
    
    func setTableHandler(){
        tableView?.estimatedRowHeight = 100
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView?.showsHorizontalScrollIndicator = false
    }
    
    private func viewModelHandler() {
        viewModel?.successHandler = { (response, error) in
            if let error = error {
                print(error)
            }
            
            if let data = response {
                print(data.title ?? "")
                self.homeData = data
                DispatchQueue.main.async {
                    self.tableView?.delegate = self
                    self.tableView?.dataSource = self
                    self.tableView?.reloadData()
                }
            }
            
        }
    }
    
    func initViewModel() {
        let service = Services()
        self.viewModel = HomeViewModel(service)
    }

    func fetchData() {
        DispatchQueue.global().async {
            self.viewModel?.fetchNasaData()
        }
        DispatchQueue.global().async {
            self.viewModelHandler()
        }

    }
    
    func setNavigationBar() {
        self.parent?.title = "Nasa's today's image"
    }

    @IBAction func search_action(sender : UIButton) {
        
    }
    
    
    func setConstarints(cell: UITableViewCell, imageView: UIImageView) {
        let leadingConstraint = NSLayoutConstraint(item: cell.contentView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: imageView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 8.0)
        let trailingConstraint = NSLayoutConstraint(item: cell.contentView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: imageView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 8.0)
        
        cell.contentView.addConstraint(leadingConstraint)
        cell.contentView.addConstraint(trailingConstraint)
        
        let topConstraint = NSLayoutConstraint(item: cell.contentView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: imageView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 15.0)
        
        let bottomConstraint = NSLayoutConstraint(item: cell.contentView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: imageView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 8.0)
        
        cell.contentView.addConstraint(topConstraint)
        cell.contentView.addConstraint(bottomConstraint)
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        print(homeData.)
        let cell:UITableViewCell = (self.tableView?.dequeueReusableCell(withIdentifier: cellReuseIdentifier))!
        cell.selectionStyle = .none
        
        if (indexPath.row == 0){
            let imgView = UIImageView(frame: CGRect(x: 0.0, y: 8.0, width: tableView.bounds.width, height: tableView.bounds.height/4))
            let url = URL(string: homeData?.url ?? "")
            if url != nil {
                let data = try? Data(contentsOf: url!)
                if let imageData = data {
                    if data != nil {
                        let image = UIImage(data: imageData)
                        imgView.image = image
                    }
                }
            } else {
                imgView.image = UIImage(named: "logo_nasa")
            }
            imgView.contentMode = .scaleAspectFit
            cell.contentView.addSubview(imgView)
            setConstarints(cell: cell, imageView: imgView)
        }
        else if (indexPath.row == 1){
            let text = homeData?.title ?? ""
            cell.textLabel?.text = "Title : " + text
            cell.textLabel?.numberOfLines = 0
        }
        else if (indexPath.row == 2){
            let text = homeData?.date ?? ""
            cell.textLabel?.text = "Date : " + text
        } else if indexPath.row == 3 {
            let text = homeData?.explanation ?? ""
            cell.textLabel?.text = "Description : " + text
            cell.textLabel?.numberOfLines = 0

        }
        else {
        }
            
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}
