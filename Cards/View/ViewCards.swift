

import UIKit

// Описание сущности View
protocol FlippableView: UIView{
    var isFlipped: Bool {get set}
    var complectionHandler: ((FlippableView)-> Void)? {get set}
    func flipWithoutCheck()
    func flip()
}

// Работа над универсаьным классом View
class CardView<ShapeType: ShapeProtocol> : UIView, FlippableView{
    var complectionHandler: ((FlippableView) -> Void)?
    var isFlipped: Bool = false {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    private let margin: Int = 10
    private let cornerRadius = 20
    
    private var startTouchPoint = CGPoint(x: 0, y: 0)
    private var ancorPoint = CGPoint(x: 0, y:0)
    private var color = UIColor()
    
    lazy var frontView = getFrontSideView()
    lazy var backView = getBackSideView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    init(frame: CGRect, color: UIColor){
        super.init(frame: frame)
        self.color = color
        flipping()
       
    makeBorder()
    }
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ancorPoint.x = (touches.first?.location(in: window).x)! - frame.minX
        ancorPoint.y = (touches.first?.location(in: window).y)! - frame.minY
        startTouchPoint = frame.origin
        }
        
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        frame.origin.x = (touches.first?.location(in: window).x)! - ancorPoint.x
        frame.origin.y = (touches.first?.location(in: window).y)! - ancorPoint.y
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if frame.origin == startTouchPoint{
            flip()
           
        }
        if frame.maxY > (self.superview?.bounds.maxY)! || frame.minY < (self.superview?.bounds.minY)! || frame.maxX > (self.superview?.bounds.maxX)! || frame.minX < (self.superview?.bounds.minX)!{
            returnToStartPoint()
        }
    }
    override func draw(_ rect: CGRect) {
        backView.removeFromSuperview()
        frontView.removeFromSuperview()
        flipping()
    }
    
    func flip() {
        let fromView = isFlipped ? frontView : backView
        let toView = isFlipped ? backView : frontView
        UIView.transition(from: fromView, to: toView, duration: 0.5, options: [.transitionFlipFromTop], completion: { _ in
            self.complectionHandler?(self)
        })
        isFlipped = !isFlipped
    }
    private func returnToStartPoint(){
        UIView.animate(withDuration: 0.2, animations: { [self] in
            frame.origin = startTouchPoint
        })
    }
    
    func flipWithoutCheck(){
        let fromView = isFlipped ? frontView : backView
        let toView = isFlipped ? backView : frontView
        UIView.transition(from: fromView, to: toView, duration: 0.5, options: [.transitionFlipFromTop], completion: { _ in
            self.complectionHandler?(self)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
            UIView.transition(from: toView, to: fromView, duration: 0.5, options: [.transitionFlipFromTop], completion: { _ in
                self.complectionHandler?(self)
            })
        }
        
    }
    
    private func flipping(){
        if isFlipped{
            self.addSubview(backView)
            self.addSubview(frontView)
        }
        else{
            self.addSubview(frontView)
            self.addSubview(backView)
        }
    }
    private func makeBorder(){
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.clipsToBounds = true
    }
    private func getFrontSideView() -> UIView{
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .white
        let shapeView = UIView(frame: CGRect(x: margin, y: margin, width: Int(self.frame.size.width) - margin*2, height: Int(self.frame.size.height) - margin*2 ))
        let shapeLayer = ShapeType(size: shapeView.frame.size, fillColor: color.cgColor)
        shapeView.layer.addSublayer(shapeLayer)
        view.addSubview(shapeView)
        view.layer.cornerRadius = CGFloat(cornerRadius)
        view.layer.masksToBounds = true
        return view
    }
    private func getBackSideView() -> UIView{
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .white
        
        switch ["circle", "line"].randomElement()! {
        case "circle":
            let layer = BackSideCircle(size: self.bounds.size, fillColor: UIColor.black.cgColor)
            view.layer.addSublayer(layer)
        case "line":
            let layer = BackSideLine(size: self.bounds.size, fillColor: UIColor.black.cgColor)
            view.layer.addSublayer(layer)
        default: break
        }
        view.layer.cornerRadius = CGFloat(cornerRadius)
        view.layer.masksToBounds = true
        return view
    }
}

