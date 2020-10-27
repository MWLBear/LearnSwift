//
//  Douban.swift
//  LearnSwift
//
//  Created by admin on 2020/9/10.
//  Copyright © 2020 apple. All rights reserved.
//

import ObjectMapper

class Douban: Mappable {
   
    var channels:[Channel]?
    
    
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    func mapping(map: Map) {
        channels <- map["channels"]
    }
    

    
    
}

class Channel: Mappable {
    
    var name: String?
    var nameEn:String?
    var channelId: String?
    var seqId: Int?
    var abbrEn: String?
    
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        nameEn <- map["name_en"]
        channelId <- map["channel_id"]
        seqId <- map["seq_id"]
        abbrEn <- map["abbr_en"]
    }
    
    
}
