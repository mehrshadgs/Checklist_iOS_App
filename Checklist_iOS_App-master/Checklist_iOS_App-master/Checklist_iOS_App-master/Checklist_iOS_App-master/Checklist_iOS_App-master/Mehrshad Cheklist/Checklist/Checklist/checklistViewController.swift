//
//  ViewController.swift
//  Checklist
//
//  Created by Catalina on 12/31/19.
//  Copyright © 2019 Mehrshad. All rights reserved.
//

import UIKit


class checkListViewController: UITableViewController,AddItemViewControolerDelegate {
    var cheklist: Cheklist!
    
    //MARK:- AddV item Viewcontoller Delagtes
    func itemDetailViewControllerDidCaneal(_controller: ItemDetailV) {
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_controller: ItemDetailV, didFinishAdding item: ChecklistItem) {
        let newRowIndex = cheklist.items.count
        cheklist.items.append(item)
        // ASK ??
        let indexPath = IndexPath(row: newRowIndex , section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
    func editItemViewController(_controller: ItemDetailV, didFinishEditing item: ChecklistItem) {
          if let index = cheklist.items.index(of: item) {
                  let indexPath = IndexPath(row: index, section: 0)
                  if let cell = tableView.cellForRow(at: indexPath){
                      configureText(for: cell, with: item)
                  }
              }
              navigationController?.popViewController(animated: true)
        
    }
    


    
    
    // 88888888888888888
   // var items = [ChecklistItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        // Do any additional setup after loading the view.
        title = cheklist.name
        
    }
    // MARK:- table viwe date source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cheklist.items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for : indexPath)
        let item = cheklist.items[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    //MARK:- Table View Delagate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            let item = cheklist.items[indexPath.row]
            
            item.toggleCheked()
            configureCheckmark(for: cell, with: item)
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //1
        cheklist.items.remove(at: indexPath.row)
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
                controller.itemTOEdiet = cheklist.items[indexPath.row]
            }
        }
    }
    /*func documentsDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Cheklist.plist")
    }
    func saveCheklistItems(){
        //1
        let encoder = PropertyListEncoder()
        //2
        do{
            //3
            let data = try encoder.encode(cheklist.items)
            //4
            try data.write(to: dataFilePath(),options : Data.WritingOptions.atomic )
           //5
        }catch{
           //6
            print("Error encoding item array:\(error.localizedDescription)")
        }
    }
    func loadCheklistItems(){
        let path  = dataFilePath()
        if let data = try? Data(contentsOf: path){
            let decoder = PropertyListDecoder()
            do{
                cheklist.items = try decoder.decode([ChecklistItem].self, from: data)
            }catch{
                print("Error encoding item array:\(error.localizedDescription)")            }
        }
    }
*/
}

