//
//  Stop+CoreDataProperties.swift
//  
//
//  Created by Paul Silva on 8/26/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Stop {

    @NSManaged var id: String?
    @NSManaged var lat: String?
    @NSManaged var long: String?
    @NSManaged var name: String?
    @NSManaged var route: String?

}
