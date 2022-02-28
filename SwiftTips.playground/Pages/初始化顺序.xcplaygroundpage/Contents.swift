//: [Previous](@previous)

import Foundation
import CoreGraphics
//我们需要保证在当前子类实例的成员初始化完成后才能调用父类的初始化方法

class Cat {
    var name: String
    init(){
        name = "cat"
    }
}

class Tiger: Cat {
    let power: Int
    override init() {
        power = 10
    }
}



class ClassA {
    let numA: Int
    init(num:Int){
        numA = num
    }
}

class ClassB: ClassA {
    let numB: Int
    
    override init(num:Int){
        numB = num + 1
        super.init(num: num)
    }
}


//与 designated 初始化方法对应的是在 init 前加上 convenience 关键字的初始化方法。这类方法 是 Swift 初始化方法中的 “二等公⺠”，只作为补充和提供使用上的方便。所有的 convenience 初始 化方法都必须调用同一个类中的 designated 初始化完成设置，另外 convenience 的初始化方法是 不能被子类重写或者是从子类中以 super 的方式被调用的。


class ClassC {
    let numC: Int
    required init(num: Int) {
        numC = num
    }
    
    convenience init(bigNum: Bool) {
        self.init(num: bigNum ? 10000 : 1)
    }
}

class ClassD: ClassC {
    let numD: Int
    
    required init(num: Int) {
        numD = num + 1
        super.init(num: num)
    }
}

let anyobj = ClassD(num: 1)
anyobj.numD
anyobj.numC

/**
 
 初始化总结:
 1.初始化路径必须保证对象完全初始化，这可以通过调用本类型的designated初始化方法来得到保证
 2.子类的designated初始化方法必须调用父类的designated方法，以保证父类也完成初始化
 
 */


//: [Next](@next)
