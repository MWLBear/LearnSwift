//
//  Profile.swift
//  Kuchi
//
//  Created by admin on 2021/1/29.
//  Copyright © 2021 Omnijar. All rights reserved.
//

struct Profile : Codable {
    var name: String
    
    init() {
        self.name = ""
    }
    
    init(named name: String) {
        self.name = name
    }
    
}
