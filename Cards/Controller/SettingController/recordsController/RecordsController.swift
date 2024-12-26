//
//  RecordsController.swift
//  Cards
//
//  Created by Ivan Pushkov on 22.10.2024.
//

import UIKit

class RecordsController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Game.instance.getRecords().count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") else{
            print("NewCell")
            let newCell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
            var config = newCell.defaultContentConfiguration()
            let record = Game.instance.getRecords()[indexPath.row]
            config.text = "Рекорд для колличества пар карточек \(record.cardPairsAmount)  - \(record.score) "
            newCell.contentConfiguration = config
            return newCell
        }
        return cell
    }
    
    
}
