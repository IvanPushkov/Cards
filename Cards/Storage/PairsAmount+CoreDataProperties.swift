//
//  PairsAmount+CoreDataProperties.swift
//  Cards
//
//  Created by Ivan Pushkov on 24.10.2024.
//
//

import Foundation
import CoreData


extension PairsAmount {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PairsAmount> {
        return NSFetchRequest<PairsAmount>(entityName: "PairsAmount")
    }

    @NSManaged public var amount: Int16

}

extension PairsAmount : Identifiable {

}
