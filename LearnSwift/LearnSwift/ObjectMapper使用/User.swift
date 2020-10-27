//
//  User.swift
//  LearnSwift
//
//  Created by admin on 2020/9/9.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import ObjectMapper

class User: Mappable {
    var username:String?
    var age:Int?
    var weight:Double?
    var bestFriend:User?
    var friends:[User]?
    var birthday:Date?
    var array:[AnyObject]?
    var dictionary:[String:AnyObject] = [:]
    
    

    
    
    init() {
            
    }
    
    required init?(map: Map) {
        if map.JSON["username"] == nil {
            return nil
        }
    }
    
    func mapping(map: Map) {
        
        username    <- map["username"]
        age         <- map["age"]
        weight      <- map["weight"]
        bestFriend  <- map["best_friend"]
        friends     <- map["friends"]
        birthday    <- (map["birthday"], DateTransform())
        array       <- map["arr"]
        dictionary  <- map["dict"]
        
    }
    

}
