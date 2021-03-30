//
//  AllListsViewController.swift
//  Checklists
//
//  Created by admin on 2021/3/30.
//

import UIKit
let cellIdentifier = "ChecklistCell"
class AllListsViewController: UITableViewController,ListDetailViewControllerDelegate {
    
    var lists : [Checklist] = [
        Checklist(name: "Birthdays"),
        Checklist(name: "Groceries"),
        Checklist(name: "Cool Apps"),
        Checklist(name: "To Do")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lists.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel!.text = lists[indexPath.row].name
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checklist = lists[indexPath.row]
        performSegue(withIdentifier: "ShowChecklist", sender: checklist)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChecklist" {
            let controller = segue.destination as! CheckListViewController
            controller.checklist = sender as? Checklist
        }else if segue.identifier == "AddChecklist" {
            let controller = segue.destination as!ListDetailViewController
            controller.delegate = self
        }
    }
    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        lists.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let controller = storyboard!.instantiateViewController(identifier: "ListDetailViewController") as! ListDetailViewController
        
        controller.delegate = self
        let checklist = lists[indexPath.row]
        controller.checklistToEdit = checklist
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    // MARK:- List Detail View Controller Delegates
    func listDetailViewControllerDidCancel( _ controller: ListDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController( _ controller: ListDetailViewController,
                                   didFinishAdding checklist: Checklist) {
        let newRowIndex = lists.count
        lists.append(checklist)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    func listDetailViewController( _ controller: ListDetailViewController,didFinishEditing checklist: Checklist) {
        
        if let index = lists.firstIndex(of: checklist) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel!.text = checklist.name
                
            }
            navigationController?.popViewController(animated: true) }
        
    }
    
}
