//
//  ViewController.swift
//  Checklist
//
//  Created by Catalina on 12/31/19.
//  Copyright © 2019 Mehrshad. All rights reserved.
//

import UIKit


class checkListViewController: UITableViewController,AddItemViewControolerDelegate {
    
    //MARK:- AddV item Viewcontoller Delagtes
    func itemDetailViewControllerDidCaneal(_controller: ItemDetailV) {
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_controller: ItemDetailV, didFinishAdding item: ChecklistItem) {
        let newRowIndex = items.count
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex , section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
    func editItemViewController(_controller: ItemDetailV, didFinishEditing item: ChecklistItem) {
          if let index = items.index(of: item) {
                  let indexPath = IndexPath(row: index, section: 0)
                  if let cell = tableView.cellForRow(at: indexPath){
                      configureText(for: cell, with: item)
                  }
              }
              navigationController?.popViewController(animated: true)
    }
    


    
    
    // 88888888888888888
    var items = [ChecklistItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
        let item1 = ChecklistItem()
        item1.text = "Walk the dog"
        items.append(item1)
        
        let item2 = ChecklistItem()
        item2.text = "Brush my teeth"
        item2.checked = true
        items.append(item2)
        
        let item3 = ChecklistItem()
        item3.text  = "Learn"
        item3.checked = true
        items.append(item3)
        
        let item4 = ChecklistItem()
        item4.text = "Score"
        items.append(item4)
        
        let item5 = ChecklistItem()
        item5.text = "ice cream"
        item5.checked = true
        items.append(item5)
        
        let item6 = ChecklistItem()
        item6.text = "yes"
        item6.checked = true
        items.append(item6)
    }
    // MARK:- table viwe date source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for : indexPath)
        let item = items[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    //MARK:- Table View Delagate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
           // var isChecked = false
            let item = items[indexPath.row]
            
            item.toggleCheked()
            configureCheckmark(for: cell, with: item)
 
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //1
        items.remove(at: indexPath.row)
        //2
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    func configureCheckmark(for cell: UITableViewCell,
                            with item : ChecklistItem ){
        let label = cell.viewWithTag(1001) as! UILabel
        if item.checked{
            label.text = "√"
        }else{
            label.text = ""
        }
    }
    func configureText(for cell: UITableViewCell , with item : ChecklistItem){
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    //MARK:- Actions

    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //1
        if segue.identifier == "AddItem"{
            //2
            let controller = segue.destination as! ItemDetailV
            //3
            controller.delagte = self
        }else if segue.identifier == "Edit Item"{
            let controller = segue.destination as! ItemDetailV
            controller.delagte = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                controller.itemTOEdiet = items[indexPath.row]
            }
            
        }
    }
        
    
}


