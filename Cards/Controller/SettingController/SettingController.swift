//
//  SettingController.swift
//  Cards
//
//  Created by Ivan Pushkov on 24.10.2024.
//

import UIKit

class SettingController: UIViewController {

    lazy var amountPairsSlider = getAmountPairsSlider()
    lazy var amountPairsLable = getAmountPairsLable()
    lazy var colorTableView = getCollorTableview()
    var colorController = ColorController()
    override func loadView() {
        super.loadView()
        view.backgroundColor = .gray
        view.addSubview(amountPairsSlider)
        view.addSubview(amountPairsLable)
        view.addSubview(colorTableView)
    }
    
    private func getAmountPairsLable() -> UILabel{
        let lable = UILabel(frame: CGRect(x: 1, y: 1, width: 200, height: 200))
        lable.text = "Колличество пар карточек - \(Int(amountPairsSlider.value))"
        lable.sizeToFit()
        lable.frame.size.width += 10
        lable.center.x = view.center.x
        lable.frame.origin.y = amountPairsSlider.frame.minY - 50
        return lable
    }
    private func getAmountPairsSlider() -> UISlider{
        let slider = UISlider(frame: CGRect(x: 16, y: 100, width: 300, height: 50))
        slider.center.x = view.center.x
        slider.maximumValue = 12
        slider.minimumValue = 1
        slider.value = Float(SettingModel.instance.amountPairs)
        slider.addTarget(nil, action: #selector(changePairsAmount), for: .valueChanged)
        return slider
    }
    private func getCollorTableview() -> UITableView{
        let colorTableView = colorController.tableView
        colorTableView?.tintColor = .clear
        colorTableView?.frame.size = CGSize(width: view.frame.width - 20, height: (view.frame.height - 170) / 2)
        colorTableView?.center.x = view.center.x
        colorTableView?.frame.origin.y = amountPairsSlider.frame.maxY - 10
        return colorTableView!
    }
    
    @objc func changePairsAmount(){
        SettingModel.instance.amountPairs = Int(amountPairsSlider.value)
        amountPairsLable.text = "Колличество пар карточек - \(Int(amountPairsSlider.value))"
    }
}

 
