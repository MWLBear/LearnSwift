//
//  ViewController.swift
//  HitList
//
//  Created by admin on 2020/10/9.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

//    var names:[String] = []
    
    var people:[NSManagedObject] = []
    
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fechRequset = NSFetchRequest<NSManagedObject>(entityName: "Person")
        do{
            people = try managedContext.fetch(fechRequset)
        }catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "The List"
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    @IBAction func addName(_ sender: Any) {
        
        let  alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle:.alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self](action) in
            guard let textField = alert.textFields?.first,let nameToSave = textField.text else {
                return
            }
            self.save(name: nameToSave)
            self.tableview.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancle", style: .cancel)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func save(name:String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
    
        person.setValue(name, forKeyPath: "name")
        
        do{
            try managedContext.save()
            people.append(person)
        }catch let error as NSError{
            print("could not save.\(error),\(error.userInfo)")
        }
        
    }
    
}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = people[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = person.value(forKeyPath: "name") as? String
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
}

