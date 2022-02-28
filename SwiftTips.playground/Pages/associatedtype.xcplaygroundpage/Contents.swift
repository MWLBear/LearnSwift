//: [Previous](@previous)

import UIKit

//associatedtype 可以在协议中添加一个限定，来指定具体的类型
//associatedtype 声明 中可以使用冒号来指定类型满足某个协议，
protocol Food { }
protocol Animal {
    associatedtype F: Food
    func eat(_ foo:F)
}
struct Meat: Food {
    let name:String
}
struct Grass: Food {
    let name:String
}


struct Tiger: Animal {
    func eat(_ foo: Meat) {
        print("eat:\(foo)")
    }
}

struct Sheep: Animal {
    func eat(_ foo: Grass) {
        print("eat:\(foo)")
    }
}


Tiger().eat(Meat(name: "rou"))
Sheep().eat(Grass(name: "cao"))

//在一个协议加入了像是 associatedtype 或者 Self 的约束 后，它将只能被用为泛型约束，而不能作为独立类型的占位使用，也失去了动态派发的特性

func isDangerous<T:Animal>(animal:T) ->Bool {
    if animal is Tiger {
        return true
    }else {
        return false
    }
}

isDangerous(animal: Tiger())
isDangerous(animal: Sheep())




//可变函数

func myFunc(numbers:Int...,string:String){
    numbers.forEach {
        for i in 0..<$0 {
            print("\(i + 1): \(string)")
        }
    }
}
myFunc(numbers: 1,2,3, string: "hello")


let name = "Tom"
let data = NSDate()
let string = NSString(format: "hello %@. Date:%@", name,data)
debugPrint(string)

//: [Next](@next)
