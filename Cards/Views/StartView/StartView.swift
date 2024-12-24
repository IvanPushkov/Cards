

import UIKit
import SnapKit
final class StartView: UIView {
     var startButton: CardButton?
     var settingButton: CardButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
        startButton = getStartButonView()
        settingButton = getSettingButtonView()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configView(){
        self.backgroundColor = .gray
    }
   
    private func getStartButonView() -> CardButton{
        let button = CardButton(frame: .zero)
        self.addSubview(button)
        button.verticalTitle(title: "START")
        button.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.centerY).offset(-20)
            make.centerX.equalToSuperview()
            make.size.equalTo(150)
        }
        return button
    }
    
    private func getSettingButtonView() -> CardButton{
        let button = CardButton(frame:.zero)
        button.verticalTitle(title: "SETTINGS")
        self.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.centerY).offset(20)
            make.size.equalTo(150)
        }
        return button
    }
    
}
