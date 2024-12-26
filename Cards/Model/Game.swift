

import Foundation

class Game{
    static let instance = Game()
    private let storage = CoreDataManager.instance
    private var cardPairsAmount = SettingModel.instance.amountPairs
    
    var corentCardAmount: Int = 0
    var startCardAmount: Int = 0
    var cards = [Card]()
    var score: Int16 = 0
    
    init(){
        startNewGame()
    }
    
    func generateCards(){
        cards = []
        for _ in 0..<startCardAmount{
            let randomCard: Card = (type: CardType.allCases.randomElement()!, color: ShapeAndColorStorageManager.instance.getIncludingColors().randomElement()!)
            cards.append(randomCard)
        }
    }
    func checkCard(firstCard: Card, secondCard: Card) -> Bool{
        if firstCard == secondCard{
            return true
        } else{
            return false
        }
    }
    func increaseScore(){
        score += 1
    }
    func getFinalResult() -> String{
        return "карточки были угаданы с \(score) попытки! Лучший результат  за всё время - \(getScoreForCorentAmount())"
    }
    
    func tryToSaveNewScore(){
        let records = getRecords()
        for record in records{
            if record.cardPairsAmount == Int16(startCardAmount){
                if record.score > score{
                    saveNewRecord(newRecord: record)
                    return
                }
                return
            }
        }
        _ = GameStorage(score: score, pairsAmount: Int16(startCardAmount))
        storage.saveContext()
    }
    
    private func saveNewRecord(newRecord record: GameStorage){
        storage.context.delete(record)
        _ = GameStorage(score: score, pairsAmount: Int16(startCardAmount))
    }
    
    
   private func getScoreForCorentAmount() -> Int{
        let records = getRecords()
        var recordScore = 0
        for record in records{
            if record.cardPairsAmount == Int16(startCardAmount){
                recordScore =  Int(record.score)
            }
        }
            return recordScore
    }
    func getRecords() -> [GameStorage] {
        storage.getValueFromStorage(withEntytiName: "GameStorage")
    }
     func startNewGame(){
       startCardAmount = self.cardPairsAmount
        corentCardAmount = self.cardPairsAmount
        generateCards()
    }
}

