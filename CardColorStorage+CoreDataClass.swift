//
//  CardColorStorage+CoreDataClass.swift
//  Cards
//
//  Created by Ivan Pushkov on 24.10.2024.
//
//

import Foundation
import CoreData

@objc(CardColorStorage)
public class CardColorStorage: NSManagedObject {
    convenience init(color: String, included: Bool){
        self.init(entity: CoreDataManager.instance.getEntityForName(entityName: "CardColorStorage"), insertInto: CoreDataManager.instance.context)
        self.included = included
        self.color = color
    }
}
