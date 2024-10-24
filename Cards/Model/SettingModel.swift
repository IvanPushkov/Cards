//
//  SettingModel.swift
//  Cards
//
//  Created by Ivan Pushkov on 22.10.2024.
//

import Foundation

protocol SettingModelProtocol{
    var amounrPairs: Int {get set}
    var arrayOfColor: [AvailableColor] {get set}
//    var arrayOfShape: [AccessibilityShape] {get set}
    
}

class SettingModel: SettingModelProtocol{
    var arrayOfColor = [AvailableColor]()
    
    static let instance = SettingModel()
    var amounrPairs: Int  {
        get {
            Int(getAmountPairsFromStorage().amount)
        }
        set(newValue){
            saveNewAmount(newAmount: newValue)
        }
    }
    func getAvailableColor() -> [AvailableColor]{
        var results = CoreDataManager.instance.getValueFromStorage(withEntytiName: "CardColorStorage")
        var arrayOfColor = [AvailableColor]()
        for result in results as! [CardColorStorage]{
            
         //   arrayOfColor.append(AvailableColor(color: CardColor(result.color), available: result.included))
        }
        return arrayOfColor
    }
    
    func getAmountPairsFromStorage() -> PairsAmount{
        let results = CoreDataManager.instance.getValueFromStorage(withEntytiName: "PairsAmount") as! [PairsAmount]
        if results.isEmpty{
            return PairsAmount(amount: 3)
        }
        return (results[0])
    }
    
    func saveNewAmount(newAmount: Int){
        let oldAmount = getAmountPairsFromStorage()
        CoreDataManager.instance.context.delete(oldAmount)
        PairsAmount(amount: Int16(newAmount))
        CoreDataManager.instance.saveContext()
    }
   
    
    
}

