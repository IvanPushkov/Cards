
import Foundation

protocol SettingModelProtocol{
   
}

class SettingModel: SettingModelProtocol{
  
    static let instance = SettingModel()
    var amountPairs: Int  {
        get {
            Int(getAmountPairsFromStorage().amount)
        }
        set(newValue){
            saveNewAmount(newAmount: newValue)
        }
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

