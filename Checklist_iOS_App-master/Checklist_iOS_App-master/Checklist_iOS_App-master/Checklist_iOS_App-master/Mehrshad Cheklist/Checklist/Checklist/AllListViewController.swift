//
//  AllListViewController.swift
//  Checklist
//
//  Created by didAR on 1/7/20.
//  Copyright © 2020 Mehrshad. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController,ListDetailViewControllerDelegate {
    //MARK:- List Detail View Controller Delegate
    func listDetaliViewControllerDidCancel(_controller: ListDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func ListDetailViewController(_controller: ListDetailViewController, didFinishAdding checklist: Cheklist) {
        let newRowIndex = lists.count
        lists.append(checklist)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func ListDetailViewController(_controller: ListDetailViewController, didFinishEditing checklist: Cheklist) {
        if let index = lists.index(of: checklist){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath){
            cell.textLabel!.text = checklist.name
        }
    }
       navigationController?.popViewController(animated: true)
    }
    
    var lists = [Cheklist]()
    let cellIdentifier =  "ChecklistCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        var list = Cheklist(name: "Birthdays")
        lists.append(list)
        
        list = Cheklist(name: "Groceries")
        lists.append(list)
        
        list = Cheklist(name: "Cool Apps")
        lists.append(list)
        
        list = Cheklist(name : "To Do")
        lists.append(list)
        
        tableView.register(UITableViewCell.self , forCellReuseIdentifier: cellIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let cheklist = lists[indexPath.row]
        cell.textLabel!.text = cheklist.name
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cheklist = lists[indexPath.row]
        performSegue(withIdentifier: "ShowCheklist", sender: cheklist)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCheklist"{
            let controller = segue.destination as! checkListViewController
            controller.cheklist = sender as? Cheklist
        }else if segue.identifier == "AddCheklist"{
            let conroller = segue.destination as! ListDetailViewController
            conroller.delegate = self
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        lists.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "ListDetailViewController" ) as! ListDetailViewController
        controller.delegate = self
        let cheklist = lists[indexPath.row]
        controller.checklistToEdit = cheklist
        navigationController?.pushViewController(controller,animated: true)
    }
}
