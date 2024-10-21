

import Foundation

class Game{
    private let storage = CoreDataManager.instance
    
    var corentCardAmount: Int = 0
    var startCardAmount: Int = 0
    var cards = [Card]()
    var score: Int16 = 0
    
    func generateCards(){
        cards = []
        for _ in 0..<startCardAmount{
            let randomCard: Card = (type: CardType.allCases.randomElement()!, color: CardColor.allCases.randomElement()!)
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
        var recordScore: Int16?
        for record in records{
            if record.cardPairsAmount == Int16(startCardAmount){
                if record.score > score{
                    let newRecord = GameStorage(score: score, pairsAmount: Int16(startCardAmount))
                    recordScore = newRecord.score
                } else{
                    recordScore = 1
                }
            }
        }
        if recordScore == nil{
            GameStorage(score: score, pairsAmount: Int16(startCardAmount))
        }
        storage.saveContext()
    }
    
    func getRecords() -> [GameStorage] {
        var storageAray = [GameStorage]()
        do {
            let results = try storage.context.fetch(storage.fetchRequest)
            for result in results as! [GameStorage]{
                storageAray.append(result)
            }
            return storageAray
        } catch {
            return storageAray
        }
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
}

