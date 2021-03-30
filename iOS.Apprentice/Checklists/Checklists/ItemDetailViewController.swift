//
//  itemDetailViewControllerr.swift
//  Checklists
//
//  Created by admin on 2021/3/29.
//

import UIKit

protocol itemDetailViewControllerrDelegate:class {
    func itemDetailViewControllerrDidCancle(_ controller: ItemDetailViewController)
    func itemDetailViewControllerr(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem)
    func itemDetailViewControllerr(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController ,UITextFieldDelegate{

    @IBOutlet weak var Name: UITextField!
    
    @IBOutlet weak var saveItem: UIBarButtonItem!
    
    weak var delegate: itemDetailViewControllerrDelegate?
    
    var itemToEdit: ChecklistItem?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Name.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let item = itemToEdit {
            title = "Edit Item"
            Name.text = item.text
            saveItem.isEnabled = true
        }
    }

    @IBAction func cancle(){
        delegate?.itemDetailViewControllerrDidCancle(self)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func done(){
        let stringName = Name.text!
        
        
        if let item = itemToEdit {
            item.text = Name.text
            delegate?.itemDetailViewControllerr(self, didFinishEditing: item)
        }else{
            let item = ChecklistItem(text: stringName, checked: false)
            delegate?.itemDetailViewControllerr(self, didFinishAdding: item)
        }
        
        
    }
 
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath)
    -> IndexPath? {
        return nil
    }
    
    //每当用户更改文本时，无论是通过点击键盘还是通过剪切/粘贴，都将调用它。
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
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
