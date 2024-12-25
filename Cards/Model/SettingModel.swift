
import Foundation

protocol SettingModelProtocol{
    var amounrPairs: Int {get set}
    var availableColors: [CardColor] {get set}
}

class SettingModel: SettingModelProtocol{
    
    var availableColors: [CardColor]{
        get{
           return getAvailableColor()
        }
        set(newAvailableColor){
          deleteColorFromStorage()
            for color in CardColor.allCases{
                if newAvailableColor.contains(color){
                    _ = CardColorStorage(included: true)
                }
                else {
                    _ = CardColorStorage(included: false)
                }
            }
            CoreDataManager.instance.saveContext()
        }
    }
    
    static let instance = SettingModel()
    var amounrPairs: Int  {
        get {
            Int(getAmountPairsFromStorage().amount)
        }
        set(newValue){
            saveNewAmount(newAmount: newValue)
        }
    }
    
    private func deleteColorFromStorage(){
        let results = CoreDataManager.instance.getValueFromStorage(withEntytiName: "CardColorStorage") as [CardColorStorage]
        for result in results {
            CoreDataManager.instance.context.delete(result)
        }
    }
    
    private func getAvailableColor() -> [CardColor]{
       
        var results = CoreDataManager.instance.getValueFromStorage(withEntytiName: "CardColorStorage") as [CardColorStorage]
        var arrayOfColor = [CardColor]()
        if results.isEmpty{
          results = turnOnAllColords()
        }
       
        for (index, result) in results.enumerated(){
            if result.included{
                arrayOfColor.append(CardColor.allCases[index])
            }
        }
        return arrayOfColor
        }

    private func turnOnAllColords() -> [CardColorStorage]{
        deleteColorFromStorage()
        for _ in CardColor.allCases.enumerated(){
             _ = CardColorStorage(included: true)
            CoreDataManager.instance.saveContext()
        }
        return CoreDataManager.instance.getValueFromStorage(withEntytiName: "CardColorStorage")
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
        _ = PairsAmount(amount: Int16(newAmount))
        CoreDataManager.instance.saveContext()
    }

}

