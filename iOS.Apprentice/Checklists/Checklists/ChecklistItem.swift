//
//  ChecklistItem.swift
//  Checklists
//
//  Created by admin on 2021/3/29.
//

import Foundation

class ChecklistItem:NSObject,Codable {
    var text:String!
    var checked:Bool!
    
 
    init(text:String,checked:Bool) {
        self.text = text
        self.checked = checked
    }
    
     func toggleChecked() {
        checked.toggle()
    }
}
