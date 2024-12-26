

import UIKit

class CardViewFactory{
    func get(_ shape: CardType, withSize size: CGSize, andColor color: CardColor) -> UIView{
        let frame = CGRect(origin: .zero, size: size)
        let viewColor = getViewColorBy(modelColor: color)
        
        switch shape{
        case .cross:
            return CardView<CrossShape>(frame: frame, color: viewColor)
        case .circle:
            return CardView<CircleShape>(frame: frame, color: viewColor)
        case .fill:
            return CardView<FillShape>(frame: frame, color: viewColor)
        case .square:
            return CardView<SquareShape>(frame: frame, color: viewColor)
        case .emptyCircle:
            return CardView<EmptyCircleShape>(frame: frame, color: viewColor)
        }
    }
    
    func getViewColorBy(modelColor: CardColor) -> UIColor{
        switch modelColor{
        case .black:
            return .black
        case .brown:
            return .brown
        case .red:
            return .red
        case .orange:
            return .orange
        case .purple:
            return .purple
        case .green:
            return .green
        case .gray:
            return .gray
        case .yelow:
            return .yellow
            
        }
    }
}
