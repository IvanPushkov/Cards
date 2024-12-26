//
//  SettingController.swift
//  Cards
//
//  Created by Ivan Pushkov on 22.10.2024.
//

import UIKit

class ColorController: UITableViewController {
    let colorStorageManager = ShapeAndColorStorageManager.instance
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        tableView.separatorStyle = .none
    }

    
   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CardColor.allCases.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell") as? SettingTableViewCell else{
            let newCell = SettingTableViewCell(style: .default, reuseIdentifier: "SettingTableViewCell")
            return newCell
        }
        let cardColor = CardColor.allCases[indexPath.row]
        cell.cardColor = cardColor
        cell.titleLable!.text = "\(cardColor.rawValue)"
        let switchCondition = colorStorageManager.getColorIncludingCondition()[indexPath.row]
        let switchColor = CardViewFactory().getViewColorBy(modelColor: cardColor)
        cell.changeSwitchCondition(isOn: switchCondition, color: switchColor)
        cell.switchColor?.addTarget(nil, action: #selector(switchColorCondition), for: .valueChanged)
        return cell
    }
    
    @objc func switchColorCondition(sender: UISwitch){
        var superView = sender.superview
        while let view = superView{
            if let cell = (superView as? SettingTableViewCell){
                colorStorageManager.changeColorConditionFor(cell.cardColor!)
                return
            }
            superView = view.superview
        }
    }

    

}
