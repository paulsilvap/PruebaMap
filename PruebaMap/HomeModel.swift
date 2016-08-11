//
//  HomeModel.swift
//  PruebaMap
//
//  Created by Paul Silva on 8/11/16.
//  Copyright © 2016 Paul Silva. All rights reserved.
//

import Foundation

protocol HomeModelProtocal: class {
    func itemsDownloaded(items: NSArray)
}

class HomeModel: NSObject, NSURLSessionDataDelegate {
    
    // properties
    
    weak var delegate: HomeModelProtocal!
    
    var data : NSMutableData = NSMutableData()
    
    let urlPath: String = "http://10.20.4.185:8000/app/stops/?format=json"
    
    func downloadItems() {
        
        let url: NSURL = NSURL(string: urlPath)!
        var session: NSURLSession!
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        let task = session.dataTaskWithURL(url)
        
        task.resume()
        
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        self.data.appendData(data);
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error != nil {
            print("Failed to download data")
        } else {
            print("Data downloaded")
            self.parseJSON()
        }
    }
    
    func parseJSON() {
        
        var jsonResult: NSMutableArray = NSMutableArray()
        
        do{
            jsonResult = try NSJSONSerialization.JSONObjectWithData(self.data, options: NSJSONReadingOptions.AllowFragments) as! NSMutableArray
        } catch let error as NSError {
            print(error)
        }
        
        var jsonElement: NSDictionary = NSDictionary()
        let locations: NSMutableArray = NSMutableArray()
        
        for i in 0 ..< jsonResult.count {
            jsonElement = jsonResult[i] as! NSDictionary
            
            let location = LocationModel()
            
            // the following ensures none of the JsonElement values are nil through optional binding
            if let id = jsonElement["Id"] as? String, let name = jsonElement["Name"] as? String, let lat = jsonElement["Latitude"] as? String, let long = jsonElement["Longitude"] as? String, let route = jsonElement["Route"] as? String{
                location.id = id
                location.name = name
                location.lat = lat
                location.long = long
                location.route = route
            }
            
            locations.addObject(location)
        }
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
            self.delegate.itemsDownloaded(locations)
            
        })
    
    }
}