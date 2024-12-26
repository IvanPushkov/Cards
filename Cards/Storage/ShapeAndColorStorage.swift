
import Foundation

class ShapeAndColorStorageManager{
    static let instance = ShapeAndColorStorageManager()
    var storage = UserDefaults.standard
    
    func getColorIncludingCondition() -> [Bool]{
        var colorCondition = [Bool]()
        for color in CardColor.allCases{
            if let condition = storage.value(forKey: color.rawValue){
                colorCondition.append((condition as! Bool))
            } else {
                storage.set(true, forKey: color.rawValue)
                colorCondition.append((true))
            }
        }
        return colorCondition
    }
    func changeColorConditionFor(_ color: CardColor){
        let condition = storage.value(forKey: color.rawValue)
        storage.set(!(condition as! Bool), forKey: color.rawValue)
    }
    func getIncludingColors() -> [CardColor]{
        var includingColors = [CardColor]()
        for (index,color) in CardColor.allCases.enumerated() {
            if getColorIncludingCondition()[index]{
                includingColors.append(color)
            }
        }
        return includingColors
    }
    
}
