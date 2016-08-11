//
//  ItineraryViewController.swift
//  PruebaMap
//
//  Created by Paul Silva on 8/4/16.
//  Copyright © 2016 Paul Silva. All rights reserved.
//

import UIKit

//@objc
//protocol MapViewControllerDelegate {
//    optional func toggleLeftPanel()
//    optional func collapseSidePanels()
//}

class ItineraryViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
//    var delegate: MapViewControllerDelegate?
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
//        addSlideMenuButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    @IBAction func menuTapped(sender: AnyObject) {
//        delegate?.toggleLeftPanel?()
//    }
    
}
