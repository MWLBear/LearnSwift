//
//  Checklist.swift
//  CheckList SwiftUI
//
//  Created by admin on 2021/4/19.
//

import Foundation
//ObservableObject is a protocol, as Checklist is adopting it (that’s right, classes both inherit from classes and adopt protcols). As the name ObservableObject implies, when an object adopts it, another object can observe it for changes. That other object is called an observer.

class Checklist: ObservableObject {
    //Marking a property in an ObservableObject as @Published means that making changes to that property notifies any observing objects
    @Published var items:[ChecklistItem] = []
    init() {
        loadChecklistItems()
    }
    
    func deleteListItem(whichElement: IndexSet) {
        items.remove(atOffsets: whichElement)
        printChecklistContents()
    }
    
    func moveListItem(whichElement: IndexSet, destination: Int) {
        items.move(fromOffsets: whichElement, toOffset:destination)
        printChecklistContents()
    }
    func printChecklistContents() {
        for item in items {
            print(item)
        }
    }
    
    //MARK: File management
    func doucumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let directory = path[0]
        print("dircetory:\(directory)")
        return directory
    }
    func dataFilePath() -> URL {
        let filePath = doucumentDirectory().appendingPathComponent("Checklist.plist")
        print("Data file path is: \(filePath)")
        return filePath
    }
    func saveChecklistItems() {
        print("saveing checklist items")
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(items)
            try data.write(to: dataFilePath(),options: Data.WritingOptions.atomic)
        } catch  {
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }
    func loadChecklistItems(){
        print("loading checklist items")
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
               items = try decoder.decode([ChecklistItem].self, from: data)
            } catch  {
                print("Error decoding item array: \(error.localizedDescription)")
            }
        }
    }
}
