//: [Previous](@previous)

import UIKit
import Foundation
import CoreGraphics


class ClassA {}
class ClassB {}

let obj: AnyObject = ClassB()

if obj is ClassA {
    print("ClassA")
}

if obj is ClassB {
    print("ClassB")
}


//kvo

class MyClass: NSObject {
    @objc  dynamic var date = Date()
}

class AnotherClass: NSObject {
    var myobject: MyClass!
    var observation: NSKeyValueObservation?
    override init() {
        super.init()
        myobject = MyClass()
        print("初始化 AnotherClass，当前日期: \(myobject.date)")
        observation = myobject.observe(\MyClass.date, options: [.new], changeHandler: { _, change in
            if let newDate = change.newValue {
            print("AnotherClass 日期发生变化 \(newDate)") }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.myobject.date = Date()
        }
        
    }
}

let obj11 = AnotherClass()



//局部 scope
let titleLabel: UILabel = {
    let label = UILabel(frame: CGRect(x: 150, y: 30, width: 200, height: 40))
    label.textColor = .red
    label.text = "Title"
    return label
}()


extension Double {
    func format(_ f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
let b = 1.234567
let f = ".2"
print("double:\(b.format(f))")

struct YourOption: OptionSet {
   let rawValue: UInt
   static let none1 = YourOption(rawValue: 0)
   static let option1 = YourOption(rawValue: 1)
   static let option2 = YourOption(rawValue: 1 << 1)
    
    
}


var result = 0
for (idx, num) in [1,2,3,4,5].enumerated() {
   result += num
    if idx == 2 {
       break
    }
}
print(result)

let int: Int = 0
let float: Float = 0.0
let double: Double = 0.0
let intNumber: NSNumber = int as NSNumber
let floatNumber: NSNumber = float as NSNumber
let doubleNumber: NSNumber = double as NSNumber
String(validatingUTF8: intNumber.objCType)
String(validatingUTF8: floatNumber.objCType)
String(validatingUTF8: doubleNumber.objCType)

let p = NSValue(cgPoint:CGPoint(x: 0, y: 0))
String(validatingUTF8: p.objCType)

let t = NSValue(cgAffineTransform: .identity)
String(validatingUTF8: t.objCType)


//: [Next](@next)

