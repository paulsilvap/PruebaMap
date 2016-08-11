//
//  LocationModel.swift
//  PruebaMap
//
//  Created by Paul Silva on 8/11/16.
//  Copyright © 2016 Paul Silva. All rights reserved.
//

import Foundation

class LocationModel: NSObject {
    
    // properties
    
    var id: String?
    var name: String?
    var lat: String?
    var long: String?
    var route: String?
    
    // empty constructor
    
    override init()
    {
        
    }
    
    //construct with @id, @name, @lat, @long, and @route parameters
    
    init(id: String, name: String, lat: String, long: String, route: String) {
        
        self.id = id
        self.name = name
        self.lat = lat
        self.long = long
        self.route = route
        
    }
    
    // prints object's current state
    
    override var description: String {
        return "Id: \(id), Name: \(name), Latitude: \(lat), Longitude: \(long), Route: \(route),"
    }
    
}