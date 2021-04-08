//
//  AppDelegate.swift
//  MyLocations
//
//  Created by admin on 2021/4/1.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Could not load data store: \(error)")
            }
        }
        return container
    }()
    lazy var managedObjectContext: NSManagedObjectContext = persistentContainer.viewContext
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let tabController = window!.rootViewController as! UITabBarController
        if let tableViewControllers = tabController.viewControllers {
            var navController = tableViewControllers[0] as! UINavigationController
            
            //// First tab
            let controller = navController.viewControllers.first as! CurrentLocationViewController
            controller.managedObjectContext = managedObjectContext
            
            // Second tab
            navController = tableViewControllers[1] as! UINavigationController
           let controller2 = navController.viewControllers.first as! LocationsViewController
           controller2.managedObjectContext = managedObjectContext
            let _ = controller2.view
            
            // Third tab
            navController = tableViewControllers[2] as! UINavigationController
            let controller3 = navController.viewControllers.first
            as! MapViewController
            controller3.managedObjectContext = managedObjectContext
        }
        
        listenForFatalCoreDateNotifications()
        return true
    }


    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    
    
    // MARK:- Helper methos
    
    func listenForFatalCoreDateNotifications() {
        NotificationCenter.default.addObserver(forName: CoreDataSaveFailedNotifacaion, object: nil, queue: OperationQueue.main) { notification in
            let message = """
There was a fatal error in the app and it cannot continue.
Press OK to terminate the app. Sorry for the inconvenience.
"""
            let alert = UIAlertController(title: "Internal Error", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { _ in
                let exception = NSException(name: NSExceptionName.invalidArgumentException, reason: "Fatal Core Data error", userInfo:  nil)
                exception.raise()
            }
          
            alert.addAction(action)
            
            let tabController = self.window!.rootViewController!
            tabController.present(alert, animated: true, completion: nil)
        }
    }
}

