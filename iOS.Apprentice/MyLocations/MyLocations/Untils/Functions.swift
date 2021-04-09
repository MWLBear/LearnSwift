//
//  Functions.swift
//  MyLocations
//
//  Created by admin on 2021/4/2.
//

import Foundation
let applicationDocumentsDirectory: URL = {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}()


func afterDelay(_ seconds: Double, run: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: run)
}

let CoreDataSaveFailedNotifacaion = Notification.Name("CoreDataSaveFailedNotification")
func fatalCoreDataError(_ error: Error) {
    print("*** Fatal error: \(error)")
    NotificationCenter.default.post(name: CoreDataSaveFailedNotifacaion, object: nil)
}

