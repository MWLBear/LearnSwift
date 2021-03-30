//
//  ViewController.swift
//  Checklists
//
//  Created by admin on 2021/3/29.
//

import UIKit

class CheckListViewController: UITableViewController,itemDetailViewControllerrDelegate {
    
    func itemDetailViewControllerrDidCancle(_ controller: ItemDetailViewController) {
       
    }
    
    func itemDetailViewControllerr(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        
        let count = checkList.count
        self.checkList.append(item)
        
        let indexPath = IndexPath(row: count, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        navigationController?.popViewController(animated: true)
        saveChecklistItems()
    }
    
    func itemDetailViewControllerr(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
        if let index = checkList.firstIndex(of: item) {
            
            let indexPath = IndexPath(row: index, section: 0)
            
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
        saveChecklistItems()

    }
    
    var checklist: Checklist!
    var checkList: [ChecklistItem] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadChecklistItems()
        title = checklist.name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = checkList[indexPath.row]
            }
        }
    }
    
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
       
        let item = checkList[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
        
            let item = checkList[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with: item)
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        saveChecklistItems()

    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        checkList.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        
        tableView.deleteRows(at: indexPaths, with: .automatic)
        saveChecklistItems()

    }
    
    func configureCheckmark(for cell: UITableViewCell,
                            with item: ChecklistItem) {
        let label = cell.viewWithTag(1001) as! UILabel
        if item.checked {
            label.text = "√"
        } else {
            label.text = ""

        }
    }
    
    func configureText(for cell: UITableViewCell,
                       with item: ChecklistItem) {
        
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
  
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    
    func saveChecklistItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(checkList)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }
    
    func loadChecklistItems() {
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path) {
            
            let decoder = PropertyListDecoder()
           
            do {
               checkList = try decoder.decode([ChecklistItem].self, from: data)
            } catch {
                print("Error decoding item array:\(error.localizedDescription)")
            }
        }
        
    }
    
}

