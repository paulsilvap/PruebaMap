//
//  Routes+CoreDataProperties.swift
//  PruebaMap
//
//  Created by Paul Silva on 9/7/16.
//  Copyright © 2016 Paul Silva. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Routes {

    @NSManaged var name: String?
    @NSManaged var stop: String?
    @NSManaged var hour: Int16
    @NSManaged var day: String?
    @NSManaged var minute: Int16

}