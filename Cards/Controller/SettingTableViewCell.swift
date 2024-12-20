//
//  SettingTableViewCell.swift
//  Cards
//
//  Created by Ivan Pushkov on 28.10.2024.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    lazy var colorView = getColorView()
    lazy var titleLable = getTitleLable()
    lazy var switchColor = getSwitchColor()
    lazy var switchLable = getSwitchLable()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getColorView() -> UIView{
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame.size = CGSize(width: 20, height: 20)
        view.layer.cornerRadius = 10
        view.backgroundColor = .gray
        return view
    }
    
    private func getTitleLable() -> UILabel{
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func getSwitchColor() -> UISwitch{
        let switchColor = UISwitch()
        switchColor.translatesAutoresizingMaskIntoConstraints = false
        return switchColor
    }
    private func getSwitchLable() -> UILabel{
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font.withSize(20)
        return label
    }

    func setupLayout(){
        let mainStackView = UIStackView(arrangedSubviews: [colorView, titleLable])
        
        contentView.addSubview(mainStackView)
        contentView.addSubview(switchColor)
        contentView.addSubview(switchLable)
        
        NSLayoutConstraint.activate([
            mainStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            switchLable.leadingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 20),
            switchLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            switchLable.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 10),
            switchLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            switchColor.trailingAnchor.constraint(equalTo: switchLable.trailingAnchor),
            switchColor.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10),
            contentView.heightAnchor.constraint(equalToConstant: 90)
                        ])
    }
    
    private func layautActivate(){
        
    }

}

extension SettingTableViewCell{
    static var identifier = "SettingTableViewCell"
}
