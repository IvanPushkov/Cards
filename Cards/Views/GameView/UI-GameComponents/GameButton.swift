//
//  GameButton.swift
//  Cards
//
//  Created by Ivan Pushkov on 25.12.2024.
//

import UIKit

final class GameButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(){
        self.layer.cornerRadius = 10
        self.setTitleColor(.brown, for: .highlighted)
        self.setTitleColor(.black, for: .normal)
        self.backgroundColor = .gray
    }

}
