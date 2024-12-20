//
//  CardColorStorage+CoreDataProperties.swift
//  Cards
//
//  Created by Ivan Pushkov on 24.10.2024.
//
//

import Foundation
import CoreData


extension CardColorStorage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardColorStorage> {
        return NSFetchRequest<CardColorStorage>(entityName: "CardColorStorage")
    }

   
    @NSManaged public var included: Bool

}

extension CardColorStorage : Identifiable {

}
