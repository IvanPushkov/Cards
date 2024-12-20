//
//  CardButton.swift
//  Cards
//
//  Created by Ivan Pushkov on 20.12.2024.
//

import UIKit

final class CardButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setShape()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setShape(){
        self.layer.cornerRadius = 20
        self.setTitleColor(.black, for: .normal)
        self.setTitleColor(.gray, for: .highlighted)
        self.setBackgroundImage(UIImage(named: "Card"), for: .normal)
        self.imageView?.layer.zPosition = -1
        self.titleLabel?.numberOfLines = self.titleLabel?.text?.count ?? 0
    }
   
     func verticalTitle(title: String){
        var verticalTitle: String = ""
        title.map { letter in
            verticalTitle.append(letter)
            verticalTitle.append("\n")
        }
        self.setTitle(verticalTitle, for: .normal)
    }

}

