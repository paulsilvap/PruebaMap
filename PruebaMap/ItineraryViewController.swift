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

class ItineraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate { //, UISearchResultsUpdating { //, //NSFetchedResultsControllerDelegate {
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
//    let searchController = UISearchController(searchResultsController: nil)
//    var managedObjectContext: NSManagedObjectContext!
    var feedItems: JSON = []
//    var filteredRoute = ]()
    
//    lazy var fetchedResultsController: NSFetchedResultsController = {
//        // Initialize Fetch Request
//        let fetchRequest = NSFetchRequest(entityName: "Stop")
//        
//        // Add Sort Descriptors
//        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//        
//        // Initialize Fetched Results Controller
//        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
//        
//        // Configure Fetched Results Controller
//        fetchedResultsController.delegate = self
//        
//        return fetchedResultsController
//    }()
    
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
        
        // initialize homeModel and fetch data
        
        fetchNextStops()
        
//        // configure search controller
//        
//        searchController.searchResultsUpdater = self
//        searchController.dimsBackgroundDuringPresentation = false
//        definesPresentationContext = true
//        tableView.tableHeaderView = searchController.searchBar
        
//        do {
//            try self.fetchedResultsController.performFetch()
//        } catch {
//            let fetchError = error as NSError
//            print("\(fetchError), \(fetchError.userInfo)")
//        }
//        
//        let userDefaults = NSUserDefaults.standardUserDefaults()
//        let didDetectIncompatibleStore = userDefaults.boolForKey("didDetectIncompatibleStore")
//        
//        if didDetectIncompatibleStore {
//            // Show Alert
//            let applicationName = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleDisplayName")
//            let message = "A serious application error occurred while \(applicationName) tried to read your data. Please contact support for help."
//            
//            self.showAlertWithTitle("Warning", message: message, cancelButtonTitle: "OK")
//        }
    }
    
    func fetchNextStops() {
        let homeModel = HomeModel()
        let urlPath = "http://192.168.0.200:8000/app/tables/itineraries/"
        homeModel.getOrders(urlPath, completionHandler: { responseObject, error in
            if responseObject.isEmpty {
                print(error)
            } else {
                self.storeFetched(responseObject)
//                self.feedItems = responseObject
//                print(responseObject.count)
            }
            return
        })
//        print(feedItems.count)
    }
    
    func storeFetched(json: JSON) {
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
    
//    func storeFetched(json: JSON) {
//        
//        //  Fetch saved data
//        let fetchRequest = NSFetchRequest(entityName: "Stop")
//        
//        // Create Entity
//        let entity = NSEntityDescription.entityForName("Stop", inManagedObjectContext: self.managedObjectContext!)
//        
//        for json in json.array! {
//            let stopId = json["id"].string
//            let predicate = NSPredicate(format: "%K == %@", "id", stopId!)
//            fetchRequest.predicate = predicate
//            
//            do {
//                let fetchedResults = try self.managedObjectContext!.executeFetchRequest(fetchRequest) as? [Stop]
//                if let results = fetchedResults {
//                    if (results.count > 0) {
//                        continue
//                    }
//                }
//            } catch {
//                let fetchError = error as NSError
//                print("\(fetchError), \(fetchError.userInfo)")
//            }
//            
//            let record = Stop(entity: entity!, insertIntoManagedObjectContext: self.managedObjectContext)
//            record.id = json["id"].string!
//            record.name = json["nombre"].string!
//            record.latitude = json["latitud"].double!
//            record.longitude = json["longitud"].double!
//            if json["rutas"].isEmpty {
//                record.route = "( )"
//            } else {
//                var routeArray: String = ""
//                for j in 0..<json["rutas"].count {
//                    routeArray += ("(\(json["rutas",j])) ")
//                }
//                record.route = routeArray
//            }
//        }
//        do {
//            // Save Record
//            try managedObjectContext?.save()
//        } catch {
//            let saveError = error as NSError
//            print("\(saveError), \(saveError.userInfo)")
//        }
//        
//    }
    
    // MARK: -
    // MARK: Table View Data Source Methods
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }
//    
//    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
//    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
////        if (editingStyle == .Delete) {
////            // Fetch Record
////            let record = fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
////            
////            // Delete Record
////            managedObjectContext.deleteObject(record)
////        }
//    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let sections = fetchedResultsController.sections {
//            let sectionInfo = sections[section]
//            return sectionInfo.numberOfObjects
//        }
        return feedItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Retrieve cell
        let cellIdentifier: String = "ItineraryCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)!
        
        // Get the info to be shown
        let item = feedItems[indexPath.row]
//        print(item.count)
        cell.textLabel!.text = String(item["parada"]) + " " + String(item["hora"]) + " " + String (item["dia"])
        
//        // Configure Table View Cell
//        configureCell(cell!, atIndexPath: indexPath)
        
        return cell
    }
    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        if let sections = fetchedResultsController.sections {
//            return sections.count
//        }
//        
//        return 0
//    }
    
//    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
////        // Fetch Record
////        let record = fetchedResultsController.objectAtIndexPath(indexPath) as! Stop
////        
////        // Update Cell
////        if let name = record.name {
////            cell.nameLabel.text = name
////        }
////        
////        cell.doneButton.selected = record.done
////        
////        cell.didTapButtonHandler = {
////            record.done = !record.done
////        }
//    }
    
    
//    // MARK: - Fetched Results Controller Delegate Methods
//    func controllerWillChangeContent(controller: NSFetchedResultsController) {
//        tableView.beginUpdates()
//    }
//    
//    func controllerDidChangeContent(controller: NSFetchedResultsController) {
//        tableView.endUpdates()
//    }
//    
//    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
//        switch (type) {
//        case .Insert:
//            if let indexPath = newIndexPath {
//                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//            }
//            break;
//        case .Delete:
//            if let indexPath = indexPath {
//                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//            }
//            break;
//        case .Update:
//            if let indexPath = indexPath {
//                let cell = tableView.cellForRowAtIndexPath(indexPath) as! ToDoCell
//                configureCell(cell, atIndexPath: indexPath)
//            }
//            break;
//        case .Move:
//            if let indexPath = indexPath {
//                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//            }
//            
//            if let newIndexPath = newIndexPath {
//                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
//            }
//            break;
//        }
//    }
    
//    // MARK: - Helper Methods
//    private func showAlertWithTitle(title: String, message: String, cancelButtonTitle: String) {
//        // Initialize Alert Controller
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
//        
//        // Configure Alert Controller
//        alertController.addAction(UIAlertAction(title: cancelButtonTitle, style: .Default, handler: { (_) -> Void in
//            let userDefaults = NSUserDefaults.standardUserDefaults()
//            userDefaults.removeObjectForKey("didDetectIncompatibleStore")
//        }))
//        
//        // Present Alert Controller
//        presentViewController(alertController, animated: true, completion: nil)
//    }

    
}
