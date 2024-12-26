//
//  SettingTableViewCell.swift
//  Cards
//
//  Created by Ivan Pushkov on 28.10.2024.
//

import UIKit
import SnapKit

final class SettingTableViewCell: UITableViewCell {
    var titleLable: UILabel?
    var switchColor: UISwitch?
    var cardColor: CardColor?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConfigurationCell()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    private func getTitleLable() -> UILabel{
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.width.equalToSuperview().multipliedBy(0.3)
        }
        return label
    }
    
    private func getSwitchColor() -> UISwitch{
        let switchColor = UISwitch()
        contentView.addSubview(switchColor)
        switchColor.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(15)
        }
        return switchColor
    }
    
    func setConfigurationCell(){
        self.selectionStyle = .none
        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.cornerRadius = 20
        titleLable = getTitleLable()
        switchColor = getSwitchColor()
    }
    
    func changeSwitchCondition(isOn: Bool, color: UIColor){
        switchColor?.isOn = isOn
        switchColor?.onTintColor = color
    }
   
}

extension SettingTableViewCell{
    static var identifier = "SettingTableViewCell"
}
