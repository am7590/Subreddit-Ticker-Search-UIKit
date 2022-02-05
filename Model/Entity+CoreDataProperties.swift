//
//  Entity+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Alek Michelson on 2/5/22.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var name: String?
    @NSManaged public var gender: String?
    @NSManaged public var age: Int64

}

extension Entity : Identifiable {

}
