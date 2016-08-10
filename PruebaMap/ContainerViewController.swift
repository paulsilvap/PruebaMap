//
//  ContainerViewController.swift
//  PruebaMap
//
//  Created by Paul Silva on 8/4/16.
//  Copyright © 2016 Paul Silva. All rights reserved.
//

import UIKit
import QuartzCore

//enum SlideOutState {
//    case BothCollapsed
//    case LeftPanelExpanded
//}

class ContainerViewController: UIViewController, UIGestureRecognizerDelegate {

//    var mapNavigationController: UINavigationController!
//    var mapViewController: MapViewController!
////    var itineraryViewController: ItineraryViewController!
////    var optionViewController: OptionViewController!
////    var rateViewController: RateViewController!
////    var routeViewController: RouteViewController!
//    var currentState: SlideOutState = .BothCollapsed {
//        didSet {
//            let shouldShowShadow = currentState != .BothCollapsed
//            showShadowForMapViewController(shouldShowShadow)
//        }
//    }
//    var leftViewController: SidePanelViewController?
//    let mapPanelExpandedOffSet: CGFloat = 180
//    var barColor: UIColor? = UIColor(red: 1, green: 87/255, blue: 34/255, alpha: 1)
    
    override func loadView() {
        super.loadView()
//        mapViewController = UIStoryboard.mapViewController()
//        mapViewController.delegate = self
//        
//        // wrap the mapViewController in a navigation controller, so we can push views to it and display bar button items in the navigation bar
//        mapNavigationController = UINavigationController(rootViewController: mapViewController)
//        view.addSubview(mapNavigationController.view)
//        addChildViewController(mapNavigationController)
//        
//        mapNavigationController.navigationBar.barTintColor = barColor
//        mapNavigationController.didMoveToParentViewController(self)
//        
//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ContainerViewController.handlePanGesture(_:)))
//        mapNavigationController.view.addGestureRecognizer(panGestureRecognizer)
//        
////        itineraryViewController = UIStoryboard.itineraryViewController()
////        itineraryViewController.delegate = self
//        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: SlideMenuDelegate
    
//    func slideMenuItemSelectedAtIndex(index: Int32) {
//        let topViewController : UIViewController = self.navigationController!.topViewController!
//        print("View Controller is : \(topViewController) \n", terminator: "")
//        switch(index){
//        case 0:
//            print("Map\n", terminator: "")
//            self.openViewControllerBasedOnIdentifier("MapViewController")
//            break
//        case 1:
//            print("Route\n", terminator: "")
//            self.openViewControllerBasedOnIdentifier("RouteViewController")
//            break
//        case 2:
//            print("Itinerary\n", terminator: "")
//            self.openViewControllerBasedOnIdentifier("ItineraryViewController")
//            break
//        case 3:
//            print("Option\n", terminator: "")
//            self.openViewControllerBasedOnIdentifier("OptionViewController")
//            break
//        case 4:
//            print("Rate\n", terminator: "")
//            self.openViewControllerBasedOnIdentifier("RateViewController")
//            break
//        default:
//            print("default\n", terminator: "")
//        }
//    }
//    
//    func openViewControllerBasedOnIdentifier(strIdentifier:String){
//        let destViewController : UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier(strIdentifier)
//        
//        let topViewController : UIViewController = self.navigationController!.topViewController!
//        
//        if (topViewController.restorationIdentifier! == destViewController.restorationIdentifier!){
//            print("Same VC")
//        } else {
//            self.navigationController!.pushViewController(destViewController, animated: true)
//        }
//    }
//    
//    func addSlideMenuButton(){
//        let btnShowMenu = UIButton(type: UIButtonType.System)
//        btnShowMenu.setImage(self.defaultMenuImage(), forState: UIControlState.Normal)
//        btnShowMenu.frame = CGRectMake(0, 0, 30, 30)
//        //        btnShowMenu.addTarget(self, action: #selector(BaseViewController.onSlideMenuButtonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
//        let customBarItem = UIBarButtonItem(customView: btnShowMenu)
//        self.navigationItem.leftBarButtonItem = customBarItem;
//    }
//    
//    func defaultMenuImage() -> UIImage {
//        var defaultMenuImage = UIImage()
//        
//        UIGraphicsBeginImageContextWithOptions(CGSizeMake(30, 22), false, 0.0)
//        
//        UIColor.blackColor().setFill()
//        UIBezierPath(rect: CGRectMake(0, 3, 30, 1)).fill()
//        UIBezierPath(rect: CGRectMake(0, 10, 30, 1)).fill()
//        UIBezierPath(rect: CGRectMake(0, 17, 30, 1)).fill()
//        
//        UIColor.whiteColor().setFill()
//        UIBezierPath(rect: CGRectMake(0, 4, 30, 1)).fill()
//        UIBezierPath(rect: CGRectMake(0, 11,  30, 1)).fill()
//        UIBezierPath(rect: CGRectMake(0, 18, 30, 1)).fill()
//        
//        defaultMenuImage = UIGraphicsGetImageFromCurrentImageContext()
//        
//        UIGraphicsEndImageContext()
//        
//        return defaultMenuImage;
//    }
    
    // MARK: MapViewControllerDelegate
    
//    func toggleLeftPanel() {
//        let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
//        if notAlreadyExpanded {
//            addLeftPanelViewController()
//        }
//        animateLeftPanel(notAlreadyExpanded)
//    }
//    
//    func addLeftPanelViewController() {
//        if (leftViewController == nil) {
//            leftViewController = UIStoryboard.leftViewController()
//            addChildSidePanelController(leftViewController!)
//        }
//    }
//    
//    func addChildSidePanelController(sidePanelController: SidePanelViewController) {
//        view.insertSubview(sidePanelController.view, atIndex: 0)
//        addChildViewController(sidePanelController)
//        sidePanelController.didMoveToParentViewController(self)
//    }
//    
//    func animateLeftPanel(shouldExpand: Bool) {
//        if (shouldExpand) {
//            currentState = .LeftPanelExpanded
//            animateMapPanelXPosition(mapPanelExpandedOffSet)
//        } else {
//            animateMapPanelXPosition(0) { finished in
//                self.currentState = .BothCollapsed
//                self.leftViewController!.view.removeFromSuperview()
//                self.leftViewController = nil;
//            }
//        }
//        
//    }
//    
//    func animateMapPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
//        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping:0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
//            self.mapNavigationController.view.frame.origin.x = targetPosition
//            }, completion: completion)
//        
//    }
//    
//    func showShadowForMapViewController(shouldShowShadow: Bool) {
//        if (shouldShowShadow) {
//            mapNavigationController.view.layer.shadowOpacity = 0.8
//        } else {
//            mapNavigationController.view.layer.shadowOpacity = 0.0
//        }
//    }


    // MARK: Gesture recognizer
    
//    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
//        let gestureIsDraggingFromLeftToRight = (recognizer.velocityInView(view).x > 0)
//        
//        switch(recognizer.state) {
//        case .Began:
//            if (currentState == .BothCollapsed) {
//                if (gestureIsDraggingFromLeftToRight) {
//                    addLeftPanelViewController()
//                }
//                showShadowForMapViewController(true)
//            }
//        case .Changed:
//            recognizer.view!.center.x = recognizer.view!.center.x + recognizer.translationInView(view).x
//            recognizer.setTranslation(CGPointZero, inView: view)
//        case .Ended:
//            if (leftViewController != nil) {
//                // animate the side panel open or closed based on whether the view has moved more or less than halfway
//                let hasMovedGreaterThanHalfway = recognizer.view!.center.x > view.bounds.size.width
//                animateLeftPanel(hasMovedGreaterThanHalfway)
//            }
//        default:
//            break
//        }
//    }
}

//private extension UIStoryboard {
//    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
//    
//    class func leftViewController() -> SidePanelViewController? {
//        return mainStoryboard().instantiateViewControllerWithIdentifier("SidePanelViewController") as? SidePanelViewController
//    }
//    
//    class func mapViewController() -> MapViewController? {
//        return mainStoryboard().instantiateViewControllerWithIdentifier("MapViewController") as? MapViewController
//    }
//    
//    class func itineraryViewController() -> ItineraryViewController? {
//        return           mainStoryboard().instantiateViewControllerWithIdentifier("ItineraryViewController") as? ItineraryViewController
//    }
//
//    
//}