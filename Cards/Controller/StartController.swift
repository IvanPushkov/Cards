

import UIKit

class StartController: UIViewController {
    lazy var startButton = getStartButonView()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .gray
        view.addSubview(startButton)
       
    }
    
   
    private func getStartButonView() -> UIButton{
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 350, height: 350))
        button.center = view.center
        button.setTitle("S\nT\nA\nR\nT", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 35)
        button.titleLabel?.numberOfLines = 5
        button.backgroundColor = UIColor(patternImage: UIImage(named:"Card")!)
       
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.brown, for: .highlighted)
        button.addTarget(self, action: #selector(startButtonAaction), for: .touchUpInside)
        button.layer.cornerRadius = 20
        return button
    }
    
    @objc func startButtonAaction(){
        self.navigationController?.pushViewController(BoardGameController(), animated: true)
    }
}
    

