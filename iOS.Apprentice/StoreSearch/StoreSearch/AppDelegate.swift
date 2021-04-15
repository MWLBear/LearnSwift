//
//  AppDelegate.swift
//  StoreSearch
//
//  Created by admin on 2021/4/12.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        detailVC.navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem
        searchVC.splitViewDetail = detailVC
        customizeAppearance()
        return true
    }

    func customizeAppearance() {
        let barTintColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 1)
        UISearchBar.appearance().barTintColor = barTintColor
        
    }
    
    // MARK:- Properties

    var splitVC: UISplitViewController {
        return window?.rootViewController as! UISplitViewController
    }
    var searchVC:SearchViewController {
        return splitVC.viewControllers.first as! SearchViewController
    }
    var detailNavController: UINavigationController {
        return splitVC.viewControllers.last as! UINavigationController
    }
    var detailVC: DetailViewController {
        return detailNavController.topViewController as! DetailViewController
    }
}

