//
//  Vehicle.swift
//  LearnSwift
//
//  Created by admin on 2020/9/9.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import ObjectMapper

class Vehicle: StaticMappable {
    
    var type:String?
    
    
    static func objectForMapping(map: Map) -> BaseMappable? {
        
        if let type: String = map["type"].value() {
            switch type {
            case "car":
                return Car()
            case "bus":
                return Bus()
            default:
                return Vehicle()
            }
        }
        return nil
    }
    
    func mapping(map: Map) {
        type <- map["type"]
    }
    

}

class Car: Vehicle {
    var name:String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["name"]
    }
    
}

class Bus: Vehicle {
    var fee: Int?
     
    override func mapping(map: Map) {
        super.mapping(map: map)
        fee <- map["fee"]
    }
}
