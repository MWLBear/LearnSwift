//: [Previous](@previous)

import UIKit
/**
 typealias AnyClass = AnyObject.Type
 
 AnyObject.Type 这种方式所得到是一个元类型 (Meta)
 在声明时我们总是在类型的名称后面 加上 .Type ，比如 A.Type 代表的是 A 这个类型的类型
 我们可以声明一个元类型来 存储 A 这个类型本身，而在从 A 中取出其类型时，我们需要使用到 .self :
 
 .self 可以用在类型后面取得类型本身，也可以用在某个实例后面取得 这个实例本身
 
 */
class A {
    class func method(){
        print("hello")
    }
}
let typeA: A.Type = A.self
typeA.method()

let anyClass: AnyClass = A.self
(anyClass as! A.Type).method()

class MusicViewController: UIViewController { }
class AlbumViewController: UIViewController { }

let useingVCTypes: [AnyClass] = [MusicViewController.self,
                                 AlbumViewController.self]
func setupViewController(_ vcTypes:[AnyClass]) {
    for vcType in vcTypes {
        if vcType is UIViewController.Type {
            let vc = (vcType as! UIViewController.Type).init()
            print(vc)
        }
    }
}

setupViewController(useingVCTypes)


// 协议和类方法中的 Self

//我们希望在协议中使用的类型就是实现这个协议本身的类型的话，就需要使用 Self 进行指代。但是在这种情况下，Self 不仅指代的是实现该协议的类型本身，也包括了这个类型的子类

protocol Copyable {
    func copy() -> Self
}

class MyClass: Copyable {
    var num = 1
    
    func copy() -> Self {
        let result = type(of: self).init()
        result.num = num
        return result
    }
    required init() {}
}

let obj = MyClass()
obj.num = 100

let newObj = obj.copy()
obj.num = 1

print(obj.num)
print(newObj.num)

//: [Next](@next)
