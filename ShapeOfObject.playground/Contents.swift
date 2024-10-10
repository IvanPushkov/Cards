//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

protocol ShapeProtocol: CAShapeLayer{
    init(size: CGSize, fillColor: CGColor)
}

protocol FlippableView: UIView{
    var isFlipped: Bool {get set}
    var complectionHandler: ((FlippableView)-> Void)? {get set}
    func flipp()
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

class BackSideSircle:CAShapeLayer, ShapeProtocol {
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        var path = UIBezierPath()
        
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

class BackSideLine: CAShapeLayer, ShapeProtocol{
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        var path = UIBezierPath()
        
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





// Работа над универсаьным классом View

class CardView<ShapeType: ShapeProtocol> : UIView, FlippableView{
    var complectionHandler: ((FlippableView) -> Void)?
    
    var isFlipped: Bool = false
    // внутренний отступ от представления
    private let margin: Int = 10
    private let cornerRadius = 20
    
    lazy var frontView = getFrontSideView()
    lazy var backView = getBackSideView()
    
    
    
    func flipp() {
        
    }
    
    var color = UIColor()
    
    init(frame: CGRect, color: UIColor){
        super.init(frame: frame)
        self.color = color
        
        if isFlipped{
            
            self.addSubview(frontView)
        } else{
            self.addSubview(backView)
         
        }
    makeBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeBorder(){
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.clipsToBounds = true
    }
    
    private func getFrontSideView() -> UIView{
        let view = UIView()
        view.backgroundColor = .white
        let shapeView = UIView(frame: CGRect(x: margin, y: margin, width: Int(self.frame.size.width) - margin*2, height: Int(self.frame.size.height) - margin*2 ))
        
        view.addSubview(shapeView)
        let layer = ShapeType(size: shapeView.frame.size, fillColor: color.cgColor)
        shapeView.layer.addSublayer(layer)
        return view
    }
    private func getBackSideView() -> UIView{
        var view = UIView(frame: self.bounds)
        view.backgroundColor = .white
        
        switch ["sircle", "line"].randomElement(){
        case "sircle": let layer = BackSideSircle(size: self.bounds.size, fillColor: color.cgColor)
            view.layer.addSublayer(layer)
        case "line": let layer = BackSideLine(size: self.bounds.size, fillColor: color.cgColor)
            view.layer.addSublayer(layer)
        default: break
        }
  
        return view
    }
   
     
}
    
class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = UIColor.white
        self.view = view
        let firstCard = CardView<CircleShape>(frame: CGRect(x: 0, y: 0, width: 120, height: 320), color: .brown)
        view.addSubview(firstCard)
        firstCard.isFlipped = true
        let secondCart = CardView<BackSideLine>(frame: CGRect(x: 200, y: 0, width: 120, height: 320), color: .blue)
        view.addSubview(secondCart)
    }
}





PlaygroundPage.current.liveView = MyViewController()




extension ShapeProtocol{
    init(){
        fatalError("Пустой инициализатор не может быть использован для создания экземпляра")
    }
}
