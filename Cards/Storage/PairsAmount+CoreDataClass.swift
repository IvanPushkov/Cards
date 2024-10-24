//
//  PairsAmount+CoreDataClass.swift
//  Cards
//
//  Created by Ivan Pushkov on 24.10.2024.
//
//

import Foundation
import CoreData

@objc(PairsAmount)
public class PairsAmount: NSManagedObject {
    convenience init(amount: Int16){
        self.init(entity: CoreDataManager.instance.getEntityForName(entityName: "PairsAmount"), insertInto: CoreDataManager.instance.context)
        self.amount = amount
    }
  }
