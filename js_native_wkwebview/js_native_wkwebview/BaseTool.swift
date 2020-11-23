//
//  BaseTool.swift
//  js_native_wkwebview
//
//  Created by admin on 2020/9/21.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit


enum Data1{
    case esqual(a:NSInteger)
    case xiaoyu
    case dayu
}


class BaseTool: NSObject {
    
    static func data() -> Bool {
        
        if getdata() > OpenTool.data() {
            return true
        }else{
            return false
        }
    }
    
    private static func getdata() -> NSInteger {
        

        let now = Date()
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        
        return timeStamp
    }
    
    func nornaldata()->NSInteger {
        
        let a = [1,6,0,1,1,3,6,0,0,0].flatMap{String($0)}.reduce("") {$0+$1}
        return NSInteger(a)!
    }
    
}
