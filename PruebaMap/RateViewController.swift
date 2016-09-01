//
//  RateViewController.swift
//  PruebaMap
//
//  Created by Paul Silva on 8/4/16.
//  Copyright © 2016 Paul Silva. All rights reserved.
//

import UIKit
import SwiftyJSON

class RateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: -
    // MARK: Properties
    
//    var selectedLocation: LocationModel = LocationModel()
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // set delegates and initialize homeModel
        
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
//        self.listTableView.reloadData()
        
    }
    
//    func itemsDownloaded(items: JSON) {
//        feedItems = items
//        self.listTableView.reloadData()
//    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
//        return feedItems.count
        return 11
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Retrieve cell
        let cellIdentifier: String = "BasicCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)!
//        // Get the location to be shown
//        let item = feedItems[indexPath.row]
//        // Get references to labels of cell
//        if item["paradas"].isEmpty {
//            myCell.textLabel!.text = "()"
//        } else {
//            var routeArray: String = ""
//            for j in 0..<item["paradas"].count {
//                routeArray += ("(\(item["paradas",j])) ")
//            }
//            myCell.textLabel!.text = String(routeArray)
//        }
//        myCell.textLabel!.text = String(item["paradas"])
        return myCell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
