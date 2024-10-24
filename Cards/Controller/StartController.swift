

import UIKit

class StartController: UIViewController {
    lazy var startButton = getStartButonView()
    lazy var settingButton = getSettingButtonView()
    override func loadView() {
        super.loadView()
        view.backgroundColor = .gray
        view.addSubview(startButton)
        view.addSubview(settingButton)
    }
    
   
    private func getStartButonView() -> UIButton{
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        button.center = view.center
        button.frame.origin.y = view.center.y - 10 - button.frame.size.height
        button.setTitle("S\nT\nA\nR\nT", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.titleLabel?.numberOfLines = button.titleLabel!.text!.count
        button.setBackgroundImage(UIImage(named: "Card"), for: .normal)
        button.imageView?.layer.zPosition = -10
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.brown, for: .highlighted)
        button.addTarget(self, action: #selector(startButtonAaction), for: .touchUpInside)
        button.layer.cornerRadius = 20
        return button
    }
    
    private func getSettingButtonView() -> UIButton{
        let button = UIButton(frame: CGRect(x: 0, y: startButton.frame.maxY + 20, width: 150, height: 150))
        button.center.x = view.center.x
        button.setTitle("S\nE\nT\n I\nN\nG", for: .normal)
        button.titleLabel?.numberOfLines = button.titleLabel!.text!.count
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.imageView?.layer.zPosition = -10
        button.setBackgroundImage(UIImage(named: "Card"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.brown, for: .highlighted)
        button.addTarget(self, action: #selector(setButtonAction), for: .touchUpInside)
        button.layer.cornerRadius = 20
        return button
    }
    
    @objc func startButtonAaction(){
        self.navigationController?.pushViewController(BoardGameController(), animated: true)
    }
    @objc func setButtonAction(){
        self.navigationController?.pushViewController(SettingController(), animated: true)
    }
}
    

