//
//  ChecklistItem.swift
//  CheckList SwiftUI
//
//  Created by admin on 2021/4/19.
//

import Foundation
struct ChecklistItem:Identifiable,Codable{
    let id = UUID()
    var name:String
    var isChecked:Bool = false
}
