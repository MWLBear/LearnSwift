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
    
    @IBOutlet weak var shouldRemindSwitch: UISwitch!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var datePickerCell: UITableViewCell!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: itemDetailViewControllerrDelegate?
    
    var itemToEdit: ChecklistItem?
    var dueDate = Date()
    var datePickerVisible = false
    
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
            shouldRemindSwitch.isOn = item.shouldRemind // add this
            dueDate = item.dueDate
            saveItem.isEnabled = true
        }
        
        updateDueDateLabel()
    }

    @IBAction func cancle(){
        delegate?.itemDetailViewControllerrDidCancle(self)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func done(){
        
        if let item = itemToEdit {
            item.text = Name.text!
            
            item.shouldRemind = shouldRemindSwitch.isOn
            item.dueDate = dueDate
          
            item.scheduleNotification()
            delegate?.itemDetailViewControllerr(self, didFinishEditing: item)
        }else{
            let item = ChecklistItem()
            item.text = Name.text!
            item.checked = false
            
            item.shouldRemind = shouldRemindSwitch.isOn
            item.dueDate = dueDate
            
            item.scheduleNotification()
            delegate?.itemDetailViewControllerr(self, didFinishAdding: item)
        }
       
    }
 
    @IBAction func shouldRemindToggled(_ sender: UISwitch) {
        if shouldRemindSwitch.isOn {
            let center = UNUserNotificationCenter.current()
           
            center.requestAuthorization(options: [.alert,.sound]) { granted, error in
                if granted {
                    print("We have permission")
                }else{
                    print("Permission denied")
                }
            }
        }
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath)
    -> IndexPath? {
        if indexPath.section == 1 && indexPath.row == 1 {
            return indexPath
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 && datePickerVisible {
            return 3
        }else {
            return super.tableView(tableView,numberOfRowsInSection: section)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 && indexPath.row == 2 {
            return datePickerCell
        }else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        var newIndexPath = indexPath
        if indexPath.section == 1 && indexPath.row == 2 {
            
            newIndexPath = IndexPath(row: 0, section: indexPath.section)
        }
        return super.tableView(tableView, indentationLevelForRowAt: newIndexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 2 {
            return 217
        }else{
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        Name.resignFirstResponder()
        if indexPath.section == 1 && indexPath.row == 1 {
            
            if !datePickerVisible {
                showDatePicker()
            }else{
                hideDatePicker()
            }
        }
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
    func textFieldDidEndEditing(_ textField: UITextField) {
        hideDatePicker()
    }
    
    // MARK:- Helper Methods
    
    func updateDueDateLabel() {
        let formater = DateFormatter()
        formater.dateStyle = .medium
        formater.timeStyle = .short
        dueDateLabel.text = formater.string(from: dueDate)
        
    }
    
    func showDatePicker() {
        datePickerVisible = true
        let indexPathDatePicker = IndexPath(row: 2, section: 1)
        tableView.insertRows(at: [indexPathDatePicker], with: .fade)
        datePicker.setDate(dueDate, animated: false)
        dueDateLabel.textColor = dueDateLabel.tintColor
    }
    
    
    func hideDatePicker(){
        if datePickerVisible {
            datePickerVisible = false
            let indexPathPicker = IndexPath(row: 2, section: 1)
            tableView.deleteRows(at: [indexPathPicker], with: .fade)
            dueDateLabel.textColor = UIColor.black
            
        }
    }
    
    @IBAction func dateChanged(_ datePicker: UIDatePicker) {
        dueDate = datePicker.date
        updateDueDateLabel()
    }
}
