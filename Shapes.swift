//
//  Shapes.swift
//  Cards
//
//  Created by Ivan Pushkov on 09.10.2024.
//

import UIKit


protocol ShapeProtocol: CAShapeLayer{
    
    init(size: CGSize, fillColor: CGColor)
    
    
}


// Создание фигуры круг
class circleShape: CAShapeLayer, ShapeProtocol{
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        // расчиываем данные для круга
        let radius = ([size.width, size.height].min() ?? 0) / 2
        let centerPoint = CGPoint(x: size.width / 2, y: size.height / 2)
        
        let path =  UIBezierPath()
        path.addArc(withCenter: centerPoint, radius: radius, startAngle: 0, endAngle: .pi*2, clockwise: true)
        path.close()
        self.path = path.cgPath
        self.fillColor = fillColor
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// создание фигуры квадрат
class SquareShape: CAShapeLayer, ShapeProtocol{
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        let sideSquare = ([size.width, size.height].min() ?? 0)
        
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: sideSquare, height: sideSquare))
        self.path = path.cgPath
        self.fillColor = fillColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// создание фигуры крест

class CrossShape: CAShapeLayer, ShapeProtocol{
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
       
        
        let reightUpCorner = CGPoint(x: size.width, y: 0)
        let reightDownCorner = CGPoint(x: size.width, y: size.height)
        let leftDownCorner = CGPoint(x: 0, y: size.height)
        
        var path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: reightDownCorner)
        path.close()
        path.move(to: leftDownCorner)
        path.addLine(to: reightUpCorner)
        path.close()
        path.lineWidth = 3
        self.strokeColor = fillColor
        self.path = path.cgPath
        self.fillColor = fillColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}

// Залитая фигура

class FillShape: CAShapeLayer, ShapeProtocol{
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        var path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: size.width, height: size.width))
        self.path = path.cgPath
        self.fillColor = fillColor
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension ShapeProtocol{
    init(){
        fatalError("Пустой инициализатор не может быть использован для создания экземпляра")
    }
}
