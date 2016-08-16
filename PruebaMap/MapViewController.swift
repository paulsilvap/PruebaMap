//
//  MapViewController.swift
//  PruebaMap
//
//  Created by Paul Silva on 7/29/16.
//  Copyright © 2016 Paul Silva. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController, GMSMapViewDelegate, HomeModelProtocal {
    
    // Properties
    
    var feedItems: NSArray = NSArray()
    var selectedLocation: LocationModel = LocationModel()
    var latArray: [String]! = []
    var longArray: [String]! = []
    var routeArray: [String]! = []
    var nameArray: [String]! = []
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var menuButton: UIBarButtonItem!

    override func loadView() {
        super.loadView()
        // Do any additional setup after loading the view, typically from a nib.
        let camera = GMSCameraPosition.cameraWithLatitude(4.637070, longitude: -74.069943, zoom: 14)
        mapView.camera = camera
        
        // set a limit for the zoom
        mapView.setMinZoom(10, maxZoom: 16)
        
        // disable indoor view
        mapView.indoorEnabled = false
        
        // enable accessibility
        mapView.accessibilityElementsHidden = false
        
        // enable My Location Function
        mapView.myLocationEnabled = true
        
        // enable My Location and Compass buttons
        // mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        
        self.mapView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            let homeModel = HomeModel()
            homeModel.delegate = self
            homeModel.downloadItems()
        }
    }

    func itemsDownloaded(items: NSArray) {
        feedItems = items
        latLongRoute(&latArray, &longArray, &nameArray, &routeArray)
        // markers
        for i in 0..<latArray.count {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(Double(latArray[i])!, Double(longArray[i])!)
            marker.icon = GMSMarker.markerImageWithColor(UIColor.blackColor())
            marker.title = nameArray[i]
//            marker.snippet = routeArray[i]
    //        marker.icon = UIImage(named: "downarrow")
            marker.map = mapView
        }
    }
    
    func latLongRoute(inout latArray: [String]!, inout _ longArray: [String]!, inout _ nameArray: [String]!, inout _ routeArray: [String]!) {
        var item: LocationModel!
        for i in 0..<feedItems.count {
            item = feedItems[i] as! LocationModel
            latArray.append(item.lat!)
            longArray.append(item.long!)
            nameArray.append(String(UTF8String: item.name!)!)
            routeArray.append(String(UTF8String: item.route!)!)
        }
        print(routeArray)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

