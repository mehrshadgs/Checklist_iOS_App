//
//  ViewController.swift
//  Checklist
//
//  Created by Catalina on 12/31/19.
//  Copyright © 2019 Mehrshad. All rights reserved.
//

import UIKit

class checkListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // MARK:- table viwe date source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for : indexPath)
        let label = cell.viewWithTag(1000) as! UILabel
        
        if indexPath.row % 5 == 0{
            label.text = "1"
        }else if indexPath.row % 5 == 1 {
            label.text = "2"
        }else if indexPath.row % 5 == 2 {
            label.text = "3"
        }else if indexPath.row % 5 == 3{
            label.text = "4"
        }else if indexPath.row % 5 == 4{
            label.text = "5"
        }
        return cell
    }
    //MARK:- Table View Delagate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            if cell.accessoryType == .none{
                cell.accessoryType = .checkmark
            }else{
                cell.accessoryType = .none
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

