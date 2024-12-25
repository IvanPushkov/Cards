

import UIKit

class BoardGameController: UIViewController {
    
    private var flippedCards = [UIView]()
    private let gameView = GameView()
    var cardViews = [UIView]()
    var cardPairsAmount = SettingModel.instance.amounrPairs
    
    lazy var game = getNewGame()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTargetsToButtons()
        view = gameView
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backButtonTitle = "Назад"
    }
    
    private func getTargetsToButtons(){
        gameView.flipButtonView?.addTarget(nil, action: #selector(flipAllCards), for: .touchUpInside)
        gameView.startButtonView?.addTarget(nil, action: #selector(startGame), for: .touchUpInside)
    }
    private func getNewGame() -> Game{
        removeOldCards()
        let game = Game()
        game.startCardAmount = cardPairsAmount
        game.corentCardAmount = cardPairsAmount
        game.generateCards()
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
    
    private func activateCards(){
        for card in cardViews{
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
        activateCards()
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
