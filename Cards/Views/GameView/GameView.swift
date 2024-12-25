

import UIKit
import SnapKit

final class GameView: UIView{
    var flipButtonView: GameButton?
    var boardGameView: UIView?
    var startButtonView: GameButton?
    
    var cardSize: CGSize{
        CGSize(width: self.frame.size.width / 4, height: self.frame.size.height / 5)
    }
    private var maxXCoordinate: Int{
        Int(self.boardGameView!.frame.width - cardSize.width)
    }
    private var maxYCoordinate: Int{
        Int(self.boardGameView!.frame.height - cardSize.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setFlipButton(){
        flipButtonView = GameButton()
        self.addSubview(flipButtonView!)
        flipButtonView?.setTitle("Перевернуть", for: .normal)
        flipButtonView!.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.width.equalTo(150)
            make.height.equalTo(50)
            make.centerX.equalToSuperview().multipliedBy(1.5)
        }
    }
    private func setStartButton(){
        startButtonView  = GameButton()
        self.addSubview(startButtonView!)
        startButtonView?.setTitle("Старт", for: .normal)
        startButtonView!.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.width.equalTo(150)
            make.height.equalTo(50)
            make.centerX.equalToSuperview().multipliedBy(0.5)
        }
    }
    private func getGameBoardView(){
        let margin = 10
        boardGameView  = UIView()
        boardGameView?.backgroundColor = UIColor(cgColor: CGColor(red: 0.1, green: 0.9, blue: 0.1, alpha: 0.3))
        boardGameView?.layer.cornerRadius = 5
        self.addSubview(boardGameView!)
        boardGameView?.snp.makeConstraints({ make in
            make.trailing.leading.equalToSuperview().inset(margin)
            make.bottom.equalToSuperview()
            make.top.equalTo(startButtonView!.snp.bottom)
        })
        
    }
    private func config(){
        setFlipButton()
        setStartButton()
        getGameBoardView()
    }
    func placeCardOnBoard(cards: [UIView]){
        for card in cards{
            let randomXCoordinate = Int.random(in: 0...maxXCoordinate)
            let randomYCoordinate = Int.random(in: 0...maxYCoordinate)
            card.frame.origin = CGPoint(x: (randomXCoordinate), y: (randomYCoordinate))
            self.addSubview(card)
        }
    }
}
