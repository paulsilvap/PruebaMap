//
//  ItineraryViewController.swift
//  PruebaMap
//
//  Created by Paul Silva on 8/4/16.
//  Copyright © 2016 Paul Silva. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData

class ItineraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate { //, UISearchResultsUpdating { 
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
//    let searchController = UISearchController(searchResultsController: nil)
    var managedObjectContext: NSManagedObjectContext!
    var feedItems: JSON = []
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "Routes")
        
        // Add Sort Descriptors
        let sortDescriptorHour = NSSortDescriptor(key: "hour", ascending: true)
        let sortDescriptorMinute = NSSortDescriptor(key: "minute", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptorHour, sortDescriptorMinute]
        
        // Initialize Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // set delegates
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Obtain an instance of managedObjectContext
        managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        // initialize homeModel and fetch data
        fetchNextStops()
        
//        // configure search controller
//        
//        searchController.searchResultsUpdater = self
//        searchController.dimsBackgroundDuringPresentation = false
//        definesPresentationContext = true
//        tableView.tableHeaderView = searchController.searchBar
        
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }
    }
    
    func fetchNextStops() {
        let homeModel = HomeModel()
        let urlPath = "http://192.168.0.200:8000/app/tables/itineraries/"
        homeModel.getOrders(urlPath, completionHandler: { responseObject, error in
            if responseObject.isEmpty {
                print(error)
            } else {
                self.storeFetched(responseObject)
            }
            return
        })
    }
    
    func storeFetched(json: JSON) {
        
        // Fetch saved data
        let fetchRequest = NSFetchRequest(entityName: "Routes")
        
        // Create Entity
        let entity =  NSEntityDescription.entityForName("Routes", inManagedObjectContext: self.managedObjectContext)
        
        for json in json.array! {
            let routeId = json["ruta"].string
            let stopId = json["parada"].string
            let predicateRoute = NSPredicate(format: "%K == %@", "name", routeId!)
            let predicateStop = NSPredicate(format: "%K == %@", "stop", stopId!)
            let compound = NSCompoundPredicate.init(andPredicateWithSubpredicates: [predicateRoute ,predicateStop])
            fetchRequest.predicate = compound
            do {
                let fetchedResults = try self.managedObjectContext!.executeFetchRequest(fetchRequest) as? [Routes]
                if let results = fetchedResults {
                    if (results.count > 0) {
                        continue
                    }
                }
            } catch {
                let fetchError = error as NSError
                print("\(fetchError), \(fetchError.userInfo)")
            }
            
            let record = Routes(entity: entity!, insertIntoManagedObjectContext: self.managedObjectContext)
            record.name = json["ruta"].string!
            record.stop = json["parada"].string!
            let timeArr = json["hora"].string!.characters.split(":").map(String.init)
            record.hour = Int16(timeArr[0])!
            record.minute = Int16(timeArr[1])!
            record.day = json["dia"].string!
        }
        
        do {
            // Save Record
            try managedObjectContext?.save()
        } catch {
            let saveError = error as NSError
            print("\(saveError), \(saveError.userInfo)")
        }
        
        feedItems = json
        self.tableView.reloadData()
    }
    
//    func filterContentForSearchText(searchText: String, scope: String = "All") {
//        do {
//            let filteredRoutes = try feedItems.filter { route in
////                return route.1.array
//            }
//            print(filteredRoutes)
//        } catch {
//            let error = error as NSError
//            print("\(error), \(error.userInfo)")
//        }
//        
//        tableView.reloadData()
//    }
    
    // MARK: -
    // MARK: Table View Data Source Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            let sectionInfo = sections[section]
            if sectionInfo.objects!.isEmpty {
                if feedItems.isEmpty {
                    return 0
                } else {
                    return feedItems.count
                }
            } else {
                return sectionInfo.numberOfObjects
            }
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Retrieve cell
        let cellIdentifier: String = "ItineraryCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)!
        
        // Check if there is information to show from cache otherwise will show info from the server
        if fetchedResultsController.fetchedObjects!.isEmpty {
            // Use feedItems info
            let item = feedItems[indexPath.row]
            
            let timeArr = item["hora"].string!.characters.split(":").map(String.init)
            
            // Get the info to be shown
            cell.textLabel!.text = String(item["parada"]) + " " + String(item["dia"]) + " " + String(timeArr[0]) + ":" + String(timeArr[1])
        } else {
            // Fetch Record
            let record = fetchedResultsController.objectAtIndexPath(indexPath) as! Routes
            
            // Get the info to be shown
            cell.textLabel!.text = record.stop! + " " + record.day! + " " + String(record.hour) + ":" + String(record.minute)
        }
        
        return cell
    }

    
}
