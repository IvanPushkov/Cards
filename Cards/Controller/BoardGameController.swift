

import UIKit

class BoardGameController: UIViewController {
    private var cardSize: CGSize{
        CGSize(width: 90, height: 140)
    }
    private var maxXCoordinate: Int{
        Int(boardGameView.frame.width - cardSize.width)
    }
    private var maxYCoordinate: Int{
        Int(boardGameView.frame.height - cardSize.height)
    }
    private var flippedCards = [UIView]()
    var cardPairsCount = 8
    var cardViews = [UIView]()
    
    lazy var game = getNewGame()
    lazy var startButtonView = getStartButtonView()
    lazy var boardGameView = getBoardGameView()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        view.addSubview(startButtonView)
        view.addSubview(boardGameView)
    }
    
    private func getNewGame() -> Game{
        let game = Game()
        game.cardsCount = cardPairsCount
        game.generateCards()
        return game
    }
    
    private func getBoardGameView() -> UIView{
        let margin = 10
        let view  = UIView()
        view.backgroundColor = .white
        view.frame.origin.x = CGFloat(margin)
        view.frame.size.width = self.view.bounds.width - CGFloat(2 * margin)
        let topPadding = SceneDelegate().window?.safeAreaInsets.top ?? 90
        view.frame.origin.y =  startButtonView.frame.maxY
        view.frame.size.height = self.view.frame.height - CGFloat(2 * margin) - topPadding - startButtonView.frame.height
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(cgColor: CGColor(red: 0.1, green: 0.9, blue: 0.1, alpha: 0.3))
        return view
    }
    
    private func getStartButtonView() -> UIButton{
        let button  = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        let window = SceneDelegate().window
        let topPadding = window?.safeAreaInsets.top
        button.frame.origin.y = topPadding ?? 90
        button.center.x = view.center.x
        button.setTitle("Старт", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.brown, for: .highlighted)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.addTarget(nil, action: #selector(startGame), for: .touchUpInside)
        return button
    }
    
    private func getCardsBy(modelData: [Card])-> [UIView]{
        var cardViews = [UIView]()
        
        let cardFactory = CardViewFactory()
        
        for (index, modelCard) in modelData.enumerated(){
            let cardOne = cardFactory.get(modelCard.type, withSize: cardSize, andColor: modelCard.color)
            cardOne.tag = index
            cardViews.append(cardOne)
            let cardTwo = cardFactory.get(modelCard.type, withSize: cardSize, andColor: modelCard.color)
            cardTwo.tag = index
            cardViews.append(cardTwo)
        }
        
        // Добавочный код для сравнения и удаления карточек
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
                if self.flippedCards.count == 2{
                    let firstCard = game.cards[self.flippedCards.first!.tag]
                    let secondCard = game.cards[self.flippedCards.last!.tag]
                    
                    if game.checkCart(firstCard: firstCard, secondCard: secondCard){
                        UIView.animate(withDuration: 0.3, animations: {
                            self.flippedCards.first!.layer.opacity = 0
                            self.flippedCards.last!.layer.opacity = 0}) { _ in
                                self.flippedCards.first?.removeFromSuperview()
                                self.flippedCards.last?.removeFromSuperview()
                                self.flippedCards = []
                            }
                    }
                    else{
                        for card in flippedCards{
                            (card as! FlippableView).flip()
                        }
                    }
                }
            }
            
        }
        
        
        return cardViews
    }
    
    private func placeCardOnBoard(cards: [UIView]){
        for  card in cardViews{
            card.removeFromSuperview()
        }
        cardViews = cards
        for card in cardViews{
            let randomXCoordinate = Int.random(in: 0...maxXCoordinate)
            let randomYCoordinate = Int.random(in: 0...maxYCoordinate)
            card.frame.origin = CGPoint(x: (randomXCoordinate), y: (randomYCoordinate))
            boardGameView.addSubview(card)
        }
    }

    @objc func startGame(){
        game = getNewGame()
        
        let cards = getCardsBy(modelData: game.cards)
        placeCardOnBoard(cards: cards)
    }

   

}
