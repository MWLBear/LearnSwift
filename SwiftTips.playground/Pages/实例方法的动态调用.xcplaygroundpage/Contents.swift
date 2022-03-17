//: [Previous](@previous)

import Foundation

class MyClass {
    func method(number: Int) -> Int {
        return number + 1
    }
}

let object = MyClass()
object.method(number: 1)

let f = MyClass.method
let object1 = MyClass()
let result = f(object)(1)

//单例
class MyManager {
    static let shared = MyManager()
    private init() {}
}



//: [Next](@next)
