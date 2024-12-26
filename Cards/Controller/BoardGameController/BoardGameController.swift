

import UIKit

final class BoardGameController: UIViewController {
    
    private let gameView = GameView()
    private var flippedCards = [UIView]()
    var cardViews = [UIView]()
    lazy var game = Game.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = "Назад"
        view = gameView
        getTargetsToButtons()
    }
    
    private func getTargetsToButtons(){
        gameView.flipButtonView?.addTarget(nil, action: #selector(flipAllCards), for: .touchUpInside)
        gameView.startButtonView?.addTarget(nil, action: #selector(startGame), for: .touchUpInside)
    }
    private func getNewGame() -> Game{
        removeOldCards()
        game.startNewGame()
        return game
    }
    
    private func removeOldCards(){
        for card in cardViews{
            card.removeFromSuperview()
        }
        cardViews = [UIView]()
    }
    
    private func getCardsBy(modelData: [Card])-> [UIView]{
        let cardFactory = CardViewFactory()
        for (index, modelCard) in modelData.enumerated(){
            let cardOne = cardFactory.get(modelCard.type, withSize: gameView.cardSize, andColor: modelCard.color)
            cardOne.tag = index
            cardViews.append(cardOne)
            let cardTwo = cardFactory.get(modelCard.type, withSize: gameView.cardSize, andColor: modelCard.color)
            cardTwo.tag = index
            cardViews.append(cardTwo)
        }
        return cardViews
    }
    
    private func activateAllCards(){
        for card in cardViews{
            activateCard(card)
        }
    }
    private func activateCard(_ card: UIView){
        (card as! FlippableView).complectionHandler = {[self] flippedCard in
            flippedCard.superview?.bringSubviewToFront(flippedCard)
            if flippedCard.isFlipped{
                self.flippedCards.append(flippedCard)
            } else {
                if let cardIndex = self.flippedCards.firstIndex(of: flippedCard){
                    self.flippedCards.remove(at: cardIndex )
                }
            }
            checkFlippedCards()
        }
    }
    
    private func checkFlippedCards(){
        if self.flippedCards.count == 2{
            game.increaseScore()
            let firstCard = game.cards[self.flippedCards.first!.tag]
            let secondCard = game.cards[self.flippedCards.last!.tag]
            if game.checkCard(firstCard: firstCard, secondCard: secondCard){
                removeGuestCards()
            }
            else{
                for card in flippedCards{
                    (card as! FlippableView).flip()
                }
            }
        }
    }
    private func removeGuestCards(){
        UIView.animate(withDuration: 0.3, animations: {
            self.flippedCards.first!.layer.opacity = 0
            self.flippedCards.last!.layer.opacity = 0}) { [self] _ in
                self.flippedCards.first?.removeFromSuperview()
                self.flippedCards.last?.removeFromSuperview()
                self.flippedCards = []
                self.game.corentCardAmount -= 1
                if self.game.corentCardAmount == 0{
                    finishGame()
                }
            }
    }
    private func finishGame(){
        game.tryToSaveNewScore()
        let alert = UIAlertController(title: "Игра окончена", message: game.getFinalResult(), preferredStyle: .alert)
        let startNewGame = UIAlertAction(title: "Новая игра", style: .default){ [self] action in
            startGame()
        }
        let lookRecord = UIAlertAction(title: "Посмотреть рекорды", style: .default){ _ in
            self.goToRecords()
        }
        alert.addAction(startNewGame)
        alert.addAction(lookRecord)
        present(alert, animated: true)
    }
    private func goToRecords(){
        navigationController?.pushViewController(RecordsController(), animated: true)
    }
    @objc func startGame(){
        game = getNewGame()
        let cards = getCardsBy(modelData: game.cards)
        gameView.placeCardOnBoard(cards: cards)
        activateAllCards()
    }
    @objc func flipAllCards(){
        game.increaseScore()
        for card in cardViews{
            if !(card as! FlippableView).isFlipped {
                (card as! FlippableView).flipWithoutCheck()
            }
        }
    }
}
