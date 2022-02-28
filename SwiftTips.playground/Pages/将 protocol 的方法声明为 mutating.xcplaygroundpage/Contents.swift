//: [Previous](@previous)

import UIKit
import CoreGraphics


protocol Vehicle {
    var numberOfWheels: Int {get}
    var color: UIColor {get set}
    
    mutating func changeColor()
}


struct MyCar: Vehicle {
    let numberOfWheels = 4
    var color = UIColor.red
    
    mutating func changeColor() {
        color = .blue
    }
}

//sequence

class ReverseIterator<T>:IteratorProtocol {
    typealias Element = T
    var array: [Element]
    var currentIndex = 0
    
    init(array:[Element]) {
        self.array = array
        currentIndex = array.count - 1
    }
    func next() -> Element? {
        if currentIndex < 0 {
            return nil
        }else {
            let element = array[currentIndex]
            currentIndex -= 1
            return element
        }
    }
}

class ReverseSequene<T>: Sequence {
    var array:[T]
    init(array:[T]) {
        self.array = array
    }
    typealias Iterator = ReverseIterator<T>
    func makeIterator() -> ReverseIterator<T> {
        return ReverseIterator(array: self.array)
    }
}

let array = [0,1,2,3,4]

for index in ReverseSequene(array: array) {
    print("index:\(index) is \(array[index])")
}


//多元组
let rect = CGRect(x: 0, y: 0, width: 120, height: 120)
let (small,large) = rect.divided(atDistance: 20, from: .minXEdge)
debugPrint(small)
debugPrint(large)


// @autoclosure和 ？？

func logIfTrue(_ predicate: @autoclosure () -> Bool){
    if predicate() {
        print("true")
    }
}

logIfTrue(2>1)



var level: Int?
var startLevel = 1
var currentLevel = level ?? startLevel
 

print("------------")
// @escaping


func doWork(block: ()->()){
    block()
}
doWork {
    print("work")
}

func doWordAsync(blcok: @escaping ()->()){
    DispatchQueue.main.async {
        blcok()
    }
}


class S {
    var foo = "foo"
    
    func method1(){
        doWork {
            print(foo)
        }
        foo = "bar"
    }
    
    func method2(){
        doWordAsync{
            print(self.foo)
        }
        foo = "bar"
    }
    
    func method3(){
        doWordAsync {
            [weak self] in
            print(self?.foo ?? "nil")
        }
        foo = "bar"
    }
}

S().method1()
S().method2()
S().method3()






















//: [Next](@next)
