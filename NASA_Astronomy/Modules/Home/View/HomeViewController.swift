//
//  HomeViewController.swift
//  NASA_Astronomy
//
//  Created by Manish on 11/12/21.
//

import UIKit
import Alamofire
import AVKit

class HomeViewController: UIViewController {
    
    @IBOutlet var tableView : UITableView?
    var viewPickerBG = UIView()
    var datePicker = UIDatePicker()
    var pickerToolbar: UIToolbar?
    var viewModel:HomeViewModel?
    var homeData: HomeModel?
    let cellReuseIdentifier = "cell"
    var loader : Loader? = nil
    var selectedDate = String()
    
    var isPostLiked = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLoader()
        initViewModel()
        fetchData()
        setTableHandler()
        setDatePickerUI()
    }
    
        
    override func viewWillAppear(_ animated: Bool) {
        setNavigationBar()
    }
    
    func setLoader(){
        self.loader = Loader(title: "Processing...", center: self.view.center)
        self.view.addSubview(self.loader!.getViewActivityIndicator())
        
        self.loader?.startAnimating()
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
                    self.loader?.stopAnimating()
                }
                
            }
            
        }
        viewModel?.saveNasaDataInCache(homeData)
     //   viewModel?.fetchNasaData()
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
        viewPickerBG.isHidden = false
    }
    
    func setDatePickerUI() {
    //    datePicker.isHidden = false

        viewPickerBG.frame = CGRect(x: 10, y: self.view.frame.size.height - 250, width: self.view.frame.width, height: 200)
        
        let doneButton = UIButton(frame: CGRect(x: self.view.frame.size.width - 120, y: 0, width: 100, height: 40))
        doneButton.setTitle("Done", for: .normal)
        doneButton.backgroundColor = .white
        doneButton.setTitleColor(UIColor.black, for: .normal)
        doneButton.addTarget(self, action: #selector(self.donebuttonTapped), for: .touchUpInside)
         viewPickerBG.addSubview(doneButton)
        
        let cancelButton = UIButton(frame: CGRect(x: 20, y: 0, width: 100, height: 40))
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.backgroundColor = .white
        cancelButton.setTitleColor(UIColor.black, for: .normal)
        cancelButton.addTarget(self, action: #selector(self.datePickerCancel), for: .touchUpInside)
         viewPickerBG.addSubview(cancelButton)

        
        datePicker.frame = CGRect(x: 0, y: 40, width: viewPickerBG.frame.size.width, height: viewPickerBG.frame.size.height-20)
        // Set some of UIDatePicker properties
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = UIColor.white
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }

        // Add an event to call onDidChangeDate function when value is changed.
        datePicker.addTarget(self, action: #selector(HomeViewController.datePickerValueChanged(_:)), for: .valueChanged)
           
                // Add DataPicker to the view
        viewPickerBG.backgroundColor = .white
        viewPickerBG.addSubview(datePicker)
        self.view.addSubview(viewPickerBG)
        
        
    
        viewPickerBG.isHidden = true
    }
    
    @objc func donebuttonTapped(sender : UIButton) {
                    //Write button action here
        viewPickerBG.isHidden = true
    }
    

    @objc func datePickerValueChanged(_ sender: UIDatePicker){
            
            // Create date formatter
            let dateFormatter: DateFormatter = DateFormatter()
            
            // Set date format
            dateFormatter.dateFormat = "YYYY-MM-DD"
            
            // Apply date format
            let selectedDate: String = dateFormatter.string(from: sender.date)
            
            print("Selected value \(selectedDate)")
            self.selectedDate = selectedDate
        }
    
    
    @objc func datePickerCancel(_ button: UIBarButtonItem?) {
        viewPickerBG.isHidden = true
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
    
    func setConstarints(cell: UITableViewCell, moviePlayer: AVPlayerViewController) {
        let leadingConstraint = NSLayoutConstraint(item: cell.contentView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: moviePlayer, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 8.0)
        let trailingConstraint = NSLayoutConstraint(item: cell.contentView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: moviePlayer, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 8.0)
        
        cell.contentView.addConstraint(leadingConstraint)
        cell.contentView.addConstraint(trailingConstraint)
        
        let topConstraint = NSLayoutConstraint(item: cell.contentView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: moviePlayer, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 15.0)
        
        let bottomConstraint = NSLayoutConstraint(item: cell.contentView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: moviePlayer, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 8.0)
        
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
          if (homeData?.media_type == "image"){
            let imgView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: tableView.bounds.height/4))
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
          else{
            let videoURL = URL(string: homeData?.url ?? "")
            let player = AVPlayer(url: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
            setConstarints(cell: cell, moviePlayer: playerViewController)
          }
            addHeartButton(cell: cell)
            
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
    
    //MARK: Favorite Button
    func addHeartButton(cell : UITableViewCell){
        let btnHeart = UIButton()
        btnHeart.setImage(UIImage(named: "Full_Heart"), for: .normal)
        btnHeart.frame = CGRect(x: self.view.frame.size.width - 60, y: 20, width: 50, height: 50)
        btnHeart.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        cell.addSubview(btnHeart)
    }
    
    @objc func pressed(btnHeart : UIButton) {
        if (isPostLiked == true){
            btnHeart.setImage(UIImage(named: "Full_Heart"), for: .normal)
            isPostLiked = false
        }
        else{
            btnHeart.setImage(UIImage(named: "Empty_heart"), for: .normal)
            isPostLiked = true
        }
        
    }
    
}
