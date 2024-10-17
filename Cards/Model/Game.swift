

import Foundation

class Game{
    var cardsCount: Int = 0
    var cards = [Card]()
    
    func generateCards(){
        cards = []
        for _ in 0...cardsCount{
            let randomCard: Card = (type: CardType.allCases.randomElement()!, color: CardColor.allCases.randomElement()!)
            cards.append(randomCard)
        }
    }
    func checkCart(firstCard: Card, secondCard: Card) -> Bool{
        if firstCard == secondCard{
            return true
        } else{
            return false
        }
    }
}

