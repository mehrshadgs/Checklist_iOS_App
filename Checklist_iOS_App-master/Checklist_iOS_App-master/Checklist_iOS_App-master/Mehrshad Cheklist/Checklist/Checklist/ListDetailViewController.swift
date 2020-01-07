//
//  ListDetailViewController.swift
//  Checklist
//
//  Created by didAR on 1/7/20.
//  Copyright © 2020 Mehrshad. All rights reserved.
//

import UIKit

protocol ListDetailViewControllerDelegate: class {
    func listDetaliViewControllerDidCancel(_controller: ListDetailViewController )
    func ListDetailViewController(_controller: ListDetailViewController , didFinishAdding checklist: Cheklist)
     func ListDetailViewController(_controller: ListDetailViewController , didFinishEditing checklist: Cheklist)
}

class ListDetailViewController: UITableViewController , UITextFieldDelegate{
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: ListDetailViewControllerDelegate?
    var checklistToEdit: Cheklist?
    override func viewDidLoad() {
        if let checklist = checklistToEdit{
            title = "Edit Cheklist"
            textField.text = checklist.name
            doneBarButton.isEnabled = true
        }
        func viewWillAppera(_ animated: Bool){
            super.viewWillAppear(animated)
            textField.becomeFirstResponder()
        }
    }
    //MARK:- Actions
    @IBAction func cancel(){
        delegate?.listDetaliViewControllerDidCancel(_controller: self)
    }
    @IBAction func done(){
        if let cheklist = checklistToEdit{
            cheklist.name = textField.text!
            delegate?.ListDetailViewController(_controller: self, didFinishEditing: cheklist)
        }else{
            let checklist = Cheklist(name: textField.text!)
            delegate?.ListDetailViewController(_controller: self, didFinishAdding: checklist)
            }
        }
    //MARK:- Table View Delegates
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    return nil
    }
    func textField(_textField: UITextField,shouldChangeCharacterIn range: NSRange,
                   replacementString string: String) -> Bool{
        let oldText = textField.text!
        let stringRange = Range(range, in:oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        doneBarButton.isEnabled = !newText.isEmpty
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        return true
    }
    }
