//
//  GameStorage+CoreDataProperties.swift
//  Cards
//
//  Created by Ivan Pushkov on 21.10.2024.
//
//

import Foundation
import CoreData


extension GameStorage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameStorage> {
        return NSFetchRequest<GameStorage>(entityName: "GameStorage")
    }

    @NSManaged public var score: Int16
    @NSManaged public var cardPairsAmount: Int16

}

extension GameStorage : Identifiable {

}
