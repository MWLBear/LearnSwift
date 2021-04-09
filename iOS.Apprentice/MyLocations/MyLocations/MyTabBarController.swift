//
//  MyTabBarController.swift
//  MyLocations
//
//  Created by admin on 2021/4/9.
//

import UIKit

class MyTabBarController: UITabBarController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return nil
    }
    

}
