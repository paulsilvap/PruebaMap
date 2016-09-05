//
//  MapViewController.swift
//  PruebaMap
//
//  Created by Paul Silva on 7/29/16.
//  Copyright © 2016 Paul Silva. All rights reserved.
//

import UIKit
import GoogleMaps
import SwiftyJSON
import CoreData

class MapViewController: UIViewController, GMSMapViewDelegate,CLLocationManagerDelegate {
    
    // MARK: -
    // MARK: Properties
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var locationManager: CLLocationManager!
    var didFindMyLocation = false
    var managedObjectContext: NSManagedObjectContext?
    
    // MARK: -
    // MARK: Manage View Controller
    
    override func loadView() {
        super.loadView()

        let zoom = zoomDevice()
        
        let camera = GMSCameraPosition.cameraWithLatitude(4.661475, longitude: -74.059930, zoom: zoom)
        mapView.camera = camera
        
        // set a limit for the zoom
        mapView.setMinZoom(10, maxZoom: zoom+2)
        
        // disable indoor view
        mapView.indoorEnabled = false
        
        // enable accessibility
        mapView.accessibilityElementsHidden = false
        
        self.mapView.delegate = self
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.mapView.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // initialize Location Manager (avoid initializing when declaring the property)
        initLocationManager()
        
        // Obtain an instance of managedObjectContext
        managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        // initialize homeModel
        fetchNextStops()
        
        // Draw Markers
        self.drawMarker()
    }
    
    // MARK: -
    // MARK: Initializers
    
    func initLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
//        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // MARK: -
    // MARK: Location Manager
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            
            // enable My Location Function
            self.mapView.myLocationEnabled = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !didFindMyLocation {
            let newLocation = locations.last
            mapView.camera = GMSCameraPosition.cameraWithTarget(newLocation!.coordinate, zoom: mapView.camera.zoom)
            
            didFindMyLocation = true
        }
        
        mapView.settings.myLocationButton = true
    }

    // MARK: -
    // MARK: Methods
    
    func fetchNextStops() {
        let homeModel = HomeModel()
        let urlPath = "http://192.168.0.50:8000/app/stops/"
        homeModel.getOrders(urlPath, completionHandler: { responseObject, error in
            if responseObject.isEmpty {
                print(error)
                
                // Draw Markers
                self.drawMarker()
                
            } else {
                self.storeFetched(responseObject)
            }
            return
        })
    }
    
    func storeFetched(json: JSON) {
        
        //  Fetch saved data
        let fetchRequest = NSFetchRequest(entityName: "Stop")
        
        // Create Entity
        let entity = NSEntityDescription.entityForName("Stop", inManagedObjectContext: self.managedObjectContext!)
        
        for json in json.array! {
            let stopId = json["id"].string
            let predicate = NSPredicate(format: "%K == %@", "id", stopId!)
            fetchRequest.predicate = predicate
            
            do {
                let fetchedResults = try self.managedObjectContext!.executeFetchRequest(fetchRequest) as? [Stop]
                if let results = fetchedResults {
                    if (results.count > 0) {
                        continue
                    }
                }
            } catch {
                let fetchError = error as NSError
                print("\(fetchError), \(fetchError.userInfo)")
            }
            
            let record = Stop(entity: entity!, insertIntoManagedObjectContext: self.managedObjectContext)
            record.id = json["id"].string!
            record.name = json["nombre"].string!
            record.latitude = json["latitud"].double!
            record.longitude = json["longitud"].double!
            if json["rutas"].isEmpty {
                record.route = "( )"
            } else {
                var routeArray: String = ""
                for j in 0..<json["rutas"].count {
                    routeArray += ("(\(json["rutas",j])) ")
                }
                record.route = routeArray
            }
        }
        do {
            // Save Record
            try managedObjectContext?.save()
        } catch {
            let saveError = error as NSError
            print("\(saveError), \(saveError.userInfo)")
        }
        
        // Draw Markers
        self.drawMarker()
    }
    
    func drawMarker() {
        // Fetch saved data
        let fetchRequest = NSFetchRequest(entityName: "Stop")
        
        do {
            let fetchedResults = try self.managedObjectContext!.executeFetchRequest(fetchRequest) as? [Stop]
            for entity in fetchedResults! {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2DMake(entity.latitude, entity.longitude)
                marker.icon = GMSMarker.markerImageWithColor(UIColor.brownColor())
                marker.title = entity.id
                marker.snippet = entity.route
                marker.map = mapView
            }
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }
    }
    
    func zoomDevice() -> Float {
        let bounds = UIScreen.mainScreen().bounds
        let width = bounds.size.width
        let height = bounds.size.height
        let radius: CGFloat = 1.00 // in hundred meters
        let zoomHeight = log((height/radius)*CGFloat(124.43359375))/log(2)
        let zoomWidth = log((width/radius)*CGFloat(124.43359375))/log(2)
        let zoom = Float((zoomHeight+zoomWidth)/2)
        return zoom
    }
    
}

