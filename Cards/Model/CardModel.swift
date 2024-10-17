

import Foundation

enum CardType: CaseIterable{
    case cross
    case square
    case circle
    case fill
}

enum CardColor: CaseIterable{
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
