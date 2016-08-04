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

@objc
protocol MapViewControllerDelegate {
    optional func toggleLeftPanel()
    optional func toggleRightPanel()
    optional func collapseSidePanels()
}

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    
    var delegate: MapViewControllerDelegate?
    
    override func loadView() {
        super.loadView()
        // Do any additional setup after loading the view, typically from a nib.
        let camera = GMSCameraPosition.cameraWithLatitude(0.419193, longitude: -78.189943, zoom: 14)
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
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        
        // The myLocation attribute of the mapView may be null
//        if let mylocation = mapView.myLocation {
//            print("User's location: \(mylocation)")
//        } else {
//            print("User's location is unknown")
//        }
        
        // marker
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(0.419193, -78.189943)
        marker.icon = GMSMarker.markerImageWithColor(UIColor.blackColor())
        marker.title = "Innopolis"
        marker.snippet = "Ciudad Yachay - Centro de Innovaciòn"
        marker.map = mapView
        
        let calle_guzman = GMSMarker()
        calle_guzman.position = CLLocationCoordinate2DMake(0.418110, -78.193866)
        calle_guzman.title = "Calle Guzmán"
        calle_guzman.snippet = "Calle en la ciudad de Urcuquí"
//        calle_guzman.icon = UIImage(named: "sadcloud")
        calle_guzman.icon = UIImage(named: "downarrow")
        calle_guzman.map = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func menuTapped(sender: AnyObject) {
    }

}

