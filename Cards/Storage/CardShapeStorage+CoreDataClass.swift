//
//  CardShapeStorage+CoreDataClass.swift
//  Cards
//
//  Created by Ivan Pushkov on 24.10.2024.
//
//

import Foundation
import CoreData

@objc(CardShapeStorage)
public class CardShapeStorage: NSManagedObject {
    convenience init(shape: String, included: Bool){
        self.init(entity: CoreDataManager.instance.getEntityForName(entityName: "CardShapeStorage"), insertInto: CoreDataManager.instance.context)
        self.shape = shape
        self.included = included
    }
    
}
