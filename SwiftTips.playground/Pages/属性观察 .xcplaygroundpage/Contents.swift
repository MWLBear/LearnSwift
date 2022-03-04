//: [Previous](@previous)

import Foundation

class MyClass {
    var date:NSDate{
        willSet {
            let d = date
            print("即将将日期从 \(d) 设定至 \(newValue)")
        }
        didSet {
            print("已经将日期从 \(oldValue) 设定至 \(date)")
        }
    }
    init() {
        date = NSDate()
    }
}

let foo = MyClass()
foo.date = foo.date.addingTimeInterval(10086)






class A {
    var number: Int {
        get {
            print("get")
            return 1
        }
        
        set {
            print("set")
        }
    }
}

class B: A {
    override var number: Int {
        willSet {print("willSet:\(newValue)")}
        didSet {print("didSet:\(oldValue)")}
    }
}

let b = B()
b.number = 0


//get
//willSet:0
//set
//didSet:1

//: [Next](@next)
