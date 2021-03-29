//
//  AddItemViewController.swift
//  Checklists
//
//  Created by admin on 2021/3/29.
//

import UIKit

protocol AddItemViewControllerDelegate:class {
    func addItemViewControllerDidCancle(_ controller: AddItemViewController)
    func addItemViewController(_ controller:AddItemViewController,didFinishAdding item: ChecklistItem)
}

class AddItemViewController: UITableViewController ,UITextFieldDelegate{

    @IBOutlet weak var Name: UITextField!
    
    @IBOutlet weak var saveItem: UIBarButtonItem!
    
    weak var delegate: AddItemViewControllerDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Name.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
    }

    @IBAction func cancle(){
        delegate?.addItemViewControllerDidCancle(self)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func done(){
        let stringName = Name.text!
        
        let item = ChecklistItem(text: stringName, checked: false)
        
        delegate?.addItemViewController(self, didFinishAdding: item)
        
       
    }
 
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath)
    -> IndexPath? {
        return nil
    }
    
    //每当用户更改文本时，无论是通过点击键盘还是通过剪切/粘贴，都将调用它。
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print("123")
        let oldText = textField.text!
        let stringRange = Range(range,in:oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        saveItem.isEnabled = !newText.isEmpty
        
        return true
        
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        saveItem.isEnabled = false
        return true
    }
}
