//
//  Student.swift
//  LearnSwift
//
//  Created by admin on 2020/3/27.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit


struct Account {
    var amount : Double = 0.0
    var owner : String = ""
    
    static var insterestRate : Double = 0.688
    
    static func intersetBy(amount:Double) -> Double{
        return insterestRate * amount
    }
}

/*
 
 
 
 
 
 
 
 
 
 */



class Student: NSObject {
    
    var name:String = ""
    var number:Int = 0
    
    
    
}

class Persion {
    
    var name : String
    var age : Int
    
    init(newName:String,newAge:Int) {
        self.name = newName
        self.age = newAge
    }
    
    func say() {
        print("name:\(self.name)")
    }
}

class People {
    
    var firstName : String = ""
    var laseName : String = ""
    var nickName : String = ""
    
    
    var fullName : String {
        
        get{
            return nickName + " " + firstName + " " + laseName
        }
    }
    
    var age : Int = 0{
        willSet {
            print("Will set an new value \(newValue) to age")
        }
        didSet {
            print("age filed changed form \(oldValue) to \(age)")
            
            if age < 10 {
                nickName = "Little"
            }else{
                nickName = "Big"
            }
            
        }
        
    }
    
    
    func toSring() -> String {
         return "Full Name: \(fullName) " + ", Age: \(age) "
    }
    

}


class SubString {
    
    var str : String = ""
    init(str:String) {
        self.str = str
    }
    
    
    subscript(start: Int, length : Int) -> String{
        
        get{
            let index1 = str.index(str.startIndex, offsetBy: start)
            let index2 = str.index(index1, offsetBy: length)
            let range = Range(uncheckedBounds: (lower: index1 , upper: index2))
            return str.substring(with: range)
        }

            

    }
    
}


/*
 
 访问控制
 private 访问级别所修饰的属性或者方法只能在当前类里访问。


 fileprivate 访问级别所修饰的属性或者方法在当前的 Swift 源文件里可以访问。
 
 public可以被任何人访问。但其他 module 中不可以被 override 和继承，而在 module 内可以被 override 和继承。
 
 open可以被任何人使用，包括 override 和继承。
 
 internal（默认访问级别，internal修饰符可写可不写）
 internal 访问级别所修饰的属性或方法在源代码所在的整个模块都可以访问。
 如果是框架或者库代码，则在整个框架内部都可以访问，框架由外部代码所引用时，则不可以访问。
 如果是 App 代码，也是在整个 App 代码，也是在整个 App 内部可以访问。

open > public > interal > fileprivate > private
 
 
 */

class A {
    fileprivate func test(){
        
    }
}
class B: A {
    
    func show(){
        test()
    }
}



//扩展只能添加新的计算型属性，不能添加存储型属性，也不能添加新的属性监视器。

extension Double
{
    func mm()->String
    {
        return "\(self/1)mm"
    }
    func cm()-> String
    {
       return "\(self/10)cm"
    }
     
    func dm()->String{
        return "\(self/100)dm"
    }
     
    func m()->String
    {
        return "\(self/1000)m"
    }
    func km()->String
    {
        return "\(self/(1000*1000))km"
    }
}

//swift协议
//Swift中协议类似于别的语言里的接口，协议里只做方法的声明，包括方法名、返回值、参数等信息，而没有具体的方法实现









