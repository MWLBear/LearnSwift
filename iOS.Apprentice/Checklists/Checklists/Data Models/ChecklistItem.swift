//
//  ChecklistItem.swift
//  Checklists
//
//  Created by admin on 2021/3/29.
//

import Foundation
import UserNotifications

class ChecklistItem:NSObject,Codable {
    var text = ""
    var checked = false
    var dueDate = Date()
    var shouldRemind = false
    var itemId = -1
    
    override init() {
        super.init()
        itemId = DataModel.nextChecklistItemID()
    }
    
     func toggleChecked() {
        checked.toggle()
    }
    
    func scheduleNotification() {
        removeNotification()
        
        if shouldRemind && dueDate > Date() {
            
            let content = UNMutableNotificationContent()
            content.title = "Reminder:"
            content.body = text
            content.sound = UNNotificationSound.default
            
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.year,.month,.day,.hour,.minute], from: dueDate)
            let tigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            
            let requset = UNNotificationRequest(identifier: "\(itemId)", content: content, trigger: tigger)
            
            let center = UNUserNotificationCenter.current()
            center.add(requset)
            
        }
    }
    
    func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["\(itemId)"])
    }
    deinit {
        removeNotification()
    }
}
