

import Foundation

enum CardType: String, CaseIterable{
    case cross
    case square
    case circle
    case emptyCircle
    case fill
}

enum CardColor: String, CaseIterable{
    case yelow
    case red
    case green
    case black
    case gray
    case brown
    case purple
    case orange 
}

typealias Card = (type: CardType, color: CardColor)
typealias AccessibilityShape = (color: CardType, available: Bool)
typealias AvailableColor = [CardColor]
