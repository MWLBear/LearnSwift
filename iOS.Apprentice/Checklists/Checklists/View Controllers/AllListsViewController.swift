//
//  AllListsViewController.swift
//  Checklists
//
//  Created by admin on 2021/3/30.
//

import UIKit
let cellIdentifier = "ChecklistCell"
class AllListsViewController: UITableViewController,ListDetailViewControllerDelegate,UINavigationControllerDelegate{
    
    var dataModel: DataModel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
      //  tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.delegate = self
        let index = dataModel.indexOfSelectedChecklist
        
        if index >= 0 && index < dataModel.lists.count {
            let checklist = dataModel.lists[index]
            performSegue(withIdentifier: "ShowChecklist", sender: checklist)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataModel.lists.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
       
        let cell: UITableViewCell!
        
        if let c  = tableView.dequeueReusableCell(withIdentifier: cellIdentifier){
            cell = c
        }else{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        let checklist = dataModel.lists[indexPath.row]
        
        cell.accessoryType = .detailDisclosureButton
        cell.textLabel!.text = checklist.name
        cell.imageView?.image = UIImage(named: checklist.iconName)
        
        let count = checklist.countUncheckedItems()
        
        if checklist.items.count == 0 {
            cell.detailTextLabel?.text = "(No Items)"
        }else{
            cell.detailTextLabel?.text = count == 0 ? "All Done" : "\(count) Remaining"

        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dataModel.indexOfSelectedChecklist = indexPath.row
        let checklist = dataModel.lists[indexPath.row]
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
        
        dataModel.lists.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let controller = storyboard!.instantiateViewController(identifier: "ListDetailViewController") as! ListDetailViewController
        
        controller.delegate = self
        let checklist = dataModel.lists[indexPath.row]
        controller.checklistToEdit = checklist
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    // MARK:- List Detail View Controller Delegates
    func listDetailViewControllerDidCancel( _ controller: ListDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController( _ controller: ListDetailViewController,
                                   didFinishAdding checklist: Checklist) {
        let newRowIndex = dataModel.lists.count
        dataModel.lists.append(checklist)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    func listDetailViewController( _ controller: ListDetailViewController,didFinishEditing checklist: Checklist) {
        
        if let index = dataModel.lists.firstIndex(of: checklist) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel!.text = checklist.name
                
            }
            navigationController?.popViewController(animated: true) }
        
    }
    // MARK:- Navigation Controller Delegates
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController === self {
            dataModel.indexOfSelectedChecklist = -1

        }
    }
    
}
