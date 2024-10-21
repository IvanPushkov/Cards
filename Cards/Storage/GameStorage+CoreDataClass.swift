//
//  GameStorage+CoreDataClass.swift
//  Cards
//
//  Created by Ivan Pushkov on 21.10.2024.
//
//

import Foundation
import CoreData

@objc(GameStorage)
public class GameStorage: NSManagedObject {
    convenience init(score: Int16, pairsAmount: Int16){
        self.init(entity: CoreDataManager.instance.getEntityForName(entityName: "GameStorage"), insertInto: CoreDataManager.instance.context)
        self.score = score
        self.cardPairsAmount = pairsAmount
    }
}
