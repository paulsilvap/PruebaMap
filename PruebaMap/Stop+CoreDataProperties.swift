//
//  Stop+CoreDataProperties.swift
//  PruebaMap
//
//  Created by Paul Silva on 9/1/16.
//  Copyright © 2016 Paul Silva. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Stop {

    @NSManaged var id: String?
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var name: String?
    @NSManaged var route: String?

}
