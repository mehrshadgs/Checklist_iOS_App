//
//  ItemDetailV.swift
//  Checklist
//
//  Created by didAR on 1/1/20.
//  Copyright © 2020 Mehrshad. All rights reserved.
//

import UIKit

protocol AddItemViewControolerDelegate : class {
    func itemDetailViewControllerDidCaneal(_controller: ItemDetailV)
    func itemDetailViewController(_controller : ItemDetailV,didFinishAdding item: ChecklistItem )
    func editItemViewController(_controller: ItemDetailV , didFinishEditing item: ChecklistItem)
}


class ItemDetailV: UITableViewController, UITextFieldDelegate {
    
    
    weak var delagte: AddItemViewControolerDelegate?
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    var itemTOEdiet : ChecklistItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        if let item =  itemTOEdiet{
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
        }
    }
    //MARK:- Actions
    @IBAction func cancel(){
        delagte?.itemDetailViewControllerDidCaneal(_controller: self)
    }
    
    @IBAction func done(){
        if let item = itemTOEdiet{
            item.text = textField.text!
            delagte?.editItemViewController(_controller: self , didFinishEditing : item)
        }else {
            let item = ChecklistItem()
            item.text = textField.text!
            delagte?.itemDetailViewController(_controller: self, didFinishAdding: item)
        }
    }
    //MARK:- Table View Delegates
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    //MARK:- Text Field Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in:oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty{
            doneBarButton.isEnabled = false
        }else{
            doneBarButton.isEnabled = true
        }
        return true
    }
    private func textFieldSouldClear(_ textField: UITextField) -> Bool{
        doneBarButton.isEnabled = false
        return true
    }
}
