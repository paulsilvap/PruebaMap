//
//  ContainerViewController.swift
//  PruebaMap
//
//  Created by Paul Silva on 8/4/16.
//  Copyright © 2016 Paul Silva. All rights reserved.
//

import UIKit
import QuartzCore

class ContainerViewController: UIViewController {

    var mapNavigationController: UINavigationController!
    var mapViewController: MapViewController!
    
    override func loadView() {
        super.loadView()
        mapViewController = UIStoryboard.mapViewController()
        mapViewController.delegate = self
        
        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        mapNavigationController = UINavigationController(rootViewController: mapViewController)
        view.addSubview(mapNavigationController.view)
        addChildViewController(mapNavigationController)
        
        mapNavigationController.didMoveToParentViewController(self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: CenterViewController delegate

extension ContainerViewController: MapViewControllerDelegate {
    
    func toggleLeftPanel() {
    }
    
    func toggleRightPanel() {
    }
    
    func addLeftPanelViewController() {
    }
    
    func addRightPanelViewController() {
    }
    
//    func animateLeftPanel(#shouldExpand: Bool) {
//    }
//    
//    func animateRightPanel(#shouldExpand: Bool) {
//    }
//    
}

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    
//    class func leftViewController() -> SidePanelViewController? {
//        return mainStoryboard().instantiateViewControllerWithIdentifier("LeftViewController") as? SidePanelViewController
//    }
//    
//    class func rightViewController() -> SidePanelViewController? {
//        return mainStoryboard().instantiateViewControllerWithIdentifier("RightViewController") as? SidePanelViewController
//    }
    
    class func mapViewController() -> MapViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("MapViewController") as? MapViewController
    }
    
}