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

class MapViewController: UIViewController, GMSMapViewDelegate, HomeModelProtocal, CLLocationManagerDelegate {
    
    // Properties
    
    var feedItems: NSArray = NSArray()
//    var selectedLocation: LocationModel = LocationModel()
    var latArray: [String]!
    var longArray: [String]!
    var routeArray: [String]!
    var nameArray: [String]!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var locationManager: CLLocationManager!
    var didFindMyLocation = false
    
    override func loadView() {
        super.loadView()
        let camera = GMSCameraPosition.cameraWithLatitude(4.62170, longitude: -74.060243, zoom: 14)
        mapView.camera = camera
        
        // set a limit for the zoom
        mapView.setMinZoom(10, maxZoom: 16)
        
        // disable indoor view
        mapView.indoorEnabled = false
        
        // enable accessibility
        mapView.accessibilityElementsHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.mapView.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // set delegates and initialize homeModel
        
        self.mapView.delegate = self
        
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems()
        
        // initialize Location Manager (avoid initializing when declaring the property)
        initLocationManager()
    }
    
    func initLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
//        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            
            // enable My Location Function
            self.mapView.myLocationEnabled = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !didFindMyLocation {
            let newLocation = locations.last
//            NSLog(String(newLocation!.coordinate), "%d")
            mapView.camera = GMSCameraPosition.cameraWithTarget(newLocation!.coordinate, zoom: mapView.camera.zoom)
            
            didFindMyLocation = true
        }
        
        mapView.settings.myLocationButton = true
    }

    func itemsDownloaded(items: NSArray) {
        feedItems = items
        latLongRoute(&latArray, &longArray, &nameArray, &routeArray)
        drawMarker()
    }
    
    func latLongRoute(inout latArray: [String]!, inout _ longArray: [String]!, inout _ nameArray: [String]!, inout _ routeArray: [String]!) {
        var item: LocationModel!
        latArray = []
        longArray = []
        nameArray = []
        routeArray = []
        for i in 0..<feedItems.count {
            item = feedItems[i] as! LocationModel
            latArray.append(item.lat!)
            longArray.append(item.long!)
            nameArray.append(String(UTF8String: item.name!)!)
            routeArray.append(String(UTF8String: item.route!)!)
        }
    }
    
    func drawMarker() {
        // markers
        for i in 0..<latArray.count {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(Double(latArray[i])!, Double(longArray[i])!)
            marker.icon = GMSMarker.markerImageWithColor(UIColor.blackColor())
            marker.title = nameArray[i]
            marker.snippet = routeArray[i]
            //        marker.icon = UIImage(named: "downarrow")
            marker.map = mapView
        }
    }
    
    func mapView(mapView: GMSMapView, didTapMarker marker: GMSMarker) -> Bool {
        // avoid moving camera when pressing marker
        mapView.selectedMarker = marker
        return true
    }
}

