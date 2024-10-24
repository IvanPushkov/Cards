//
//  CardShapeStorage+CoreDataProperties.swift
//  Cards
//
//  Created by Ivan Pushkov on 24.10.2024.
//
//

import Foundation
import CoreData


extension CardShapeStorage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardShapeStorage> {
        return NSFetchRequest<CardShapeStorage>(entityName: "CardShapeStorage")
    }

    @NSManaged public var shape: String?
    @NSManaged public var included: Bool

}

extension CardShapeStorage : Identifiable {

}
