

import UIKit

class BoardGameController: UIViewController {
    
    private var cardSize: CGSize{
        CGSize(width: view.frame.size.width / 4, height: view.frame.size.height / 5)
    }
    private var maxXCoordinate: Int{
        Int(boardGameView.frame.width - cardSize.width)
    }
    private var maxYCoordinate: Int{
        Int(boardGameView.frame.height - cardSize.height)
    }
    private var flippedCards = [UIView]()
    
    var cardViews = [UIView]()
    var cardPairsAmount = 5

    lazy var game = getNewGame()
    lazy var startButtonView = getStartButtonView()
    lazy var flipButtonView = getFlipButtonView()
    lazy var boardGameView = getBoardGameView()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        view.addSubview(startButtonView)
        view.addSubview(flipButtonView)
        view.addSubview(boardGameView)
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
    
    private func getBoardGameView() -> UIView{
        let margin = 10
        let view  = UIView()
        view.backgroundColor = .white
        view.frame.origin.x = CGFloat(margin)
        view.frame.size.width = self.view.bounds.width - CGFloat(2 * margin)
        view.frame.origin.y =  startButtonView.frame.maxY
        view.frame.size.height = self.view.frame.height - CGFloat(2 * margin) - startButtonView.frame.maxY
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(cgColor: CGColor(red: 0.1, green: 0.9, blue: 0.1, alpha: 0.3))
        return view
    }
    
    private func getFlipButtonView()-> UIButton{
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        button.frame.origin.y = startButtonView.frame.origin.y
        button.center.x = view.center.x * 1.5
        button.setTitle("Перевернуть", for: .normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(.brown, for: .highlighted)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .gray
        button.addTarget(nil, action: #selector(flipAllCards), for: .touchUpInside)
        return button
    }
    
    private func getStartButtonView() -> UIButton{
        let button  = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        let guideSafeArea = self.view.safeAreaLayoutGuide
        let topPadding = guideSafeArea.layoutFrame.size.height
        button.frame.origin.y = topPadding + button.frame.size.height + 20
        button.center.x = view.center.x / 2
        button.setTitle("Старт", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.brown, for: .highlighted)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.addTarget(nil, action: #selector(startGame), for: .touchUpInside)
        return button
    }
    
    private func getCardsBy(modelData: [Card])-> [UIView]{
        let cardFactory = CardViewFactory()
        for (index, modelCard) in modelData.enumerated(){
            let cardOne = cardFactory.get(modelCard.type, withSize: cardSize, andColor: modelCard.color)
            cardOne.tag = index
            cardViews.append(cardOne)
            let cardTwo = cardFactory.get(modelCard.type, withSize: cardSize, andColor: modelCard.color)
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
    
    private func placeCardOnBoard(cards: [UIView]){
        for card in cards{
            let randomXCoordinate = Int.random(in: 0...maxXCoordinate)
            let randomYCoordinate = Int.random(in: 0...maxYCoordinate)
            card.frame.origin = CGPoint(x: (randomXCoordinate), y: (randomYCoordinate))
            boardGameView.addSubview(card)
            activateCards()
        }
    }
    private func finishGame(){
        game.tryToSaveNewScore()
        let alert = UIAlertController(title: "Игра окончена", message: game.getFinalResult(), preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "Новая игра", style: .default){ [self] action in
            startGame()
        }
        alert.addAction(alertButton)
        present(alert, animated: true)
    }
    
    @objc func startGame(){
        game = getNewGame()
        let cards = getCardsBy(modelData: game.cards)
        placeCardOnBoard(cards: cards)
    }
    @objc func flipAllCards(){
        game.increaseScore()
        var noFlipedCards = [UIView]()
        for card in cardViews{
            if !(card as! FlippableView).isFlipped {
                noFlipedCards.append(card)
            }
        }
        for card in noFlipedCards{
            if let card = (card as? FlippableView){
                card.flipWithoutCheck()
            
            }
        }
    }
}
