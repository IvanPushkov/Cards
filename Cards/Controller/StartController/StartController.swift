

import UIKit

class StartController: UIViewController {
    private let startView = StartView()
    override func viewDidLoad() {
        super.viewDidLoad()
        startView.settingButton?.addTarget(self, action: #selector(settingButtonAction), for: .touchUpInside)
        startView.startButton?.addTarget(self, action: #selector(startButtonAaction), for: .touchUpInside)
        view = startView
    }
    
    @objc func startButtonAaction(){
        self.navigationController?.pushViewController(BoardGameController(), animated: true)
    }
    
    @objc func settingButtonAction(){
        self.navigationController?.pushViewController(SettingController(), animated: true)
    }
}
    

