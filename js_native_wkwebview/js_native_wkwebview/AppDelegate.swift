//
//  AppDelegate.swift
//  js_native_wkwebview
//
//  Created by admin on 2020/9/16.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? 
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       // CoreData.getLocalCoreData()
        let a = OpenBase.mcqtrivia_formatChangeCheck()
        let b = OpenBase.mcqtrivia_myCurrentTime()
        print("a = \(a),b= \(b)")
        
        var str = "98475810820200930"
       
        if str.getNowFime() {
            print("时间戳没有到")
        }else{
            print("时间戳到了.")
            if str.getlanguage() {
                print("时间戳到了并且是中文..")
            }
        }
        return true
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        //CoreData.getLocalCoreData()
        
    }
    // MARK: UISceneSession Lifecycle
}

