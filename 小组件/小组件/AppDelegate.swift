//
//  AppDelegate.swift
//  小组件
//
//  Created by admin on 2021/10/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let q = NSURLComponents(string: url.absoluteString)?.host
        
        print("url: \(url): q:\(q)")
        return true
    }
}

