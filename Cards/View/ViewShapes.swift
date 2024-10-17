

import UIKit

// Описание сущности фигура
protocol ShapeProtocol: CAShapeLayer{
    init(size: CGSize, fillColor: CGColor)
}

extension ShapeProtocol{
    init(){
        fatalError("Пустой инициализатор не может быть использован для создания экземпляра")
    }
}



// Создание фигуры круг
class CircleShape: CAShapeLayer, ShapeProtocol{
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

        let path = UIBezierPath()
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
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: size.width, height: size.width))
        self.path = path.cgPath
        self.fillColor = fillColor
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

// Фон круги
class BackSideCircle:CAShapeLayer, ShapeProtocol {
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        let path = UIBezierPath()
        
        for _ in 0...15{
            let randomX = Int.random(in: (0...Int(size.width)))
            let randomY = Int.random(in: (0...Int(size.height)))
            
            let center = CGPoint(x: randomX, y: randomY)
            let randomRadius = Int.random(in: 0...5)
            path.move(to: center)
            path.addArc(withCenter: center, radius: CGFloat(randomRadius), startAngle: 0, endAngle: .pi*2, clockwise: true)
        }
        self.path = path.cgPath
        self.fillColor = fillColor
        self.strokeColor = fillColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

//  Фон линии
class BackSideLine: CAShapeLayer, ShapeProtocol{
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        let path = UIBezierPath()
        
        for _ in 0...15{
            var randomXStart: Int  {Int.random(in: (0...Int(size.width)))}
            let randomXFinish = randomXStart
            var randomYStart: Int  {Int.random(in: (0...Int(size.height)))}
            let randomYFinish = randomYStart
            
            let startPoint = CGPoint(x: randomXStart, y: randomYStart)
            let finishPoint = CGPoint(x: randomXFinish, y: randomYFinish)
            path.move(to: startPoint)
            path.addLine(to: finishPoint)
        }
        self.path = path.cgPath
        self.fillColor = fillColor
        self.strokeColor = fillColor
        self.lineCap = .round
        self.lineWidth = 3
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

