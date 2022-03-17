//: [Previous](@previous)

import Foundation



func printLog<T>(_ message: T,
                 file: String = #file,
                 method: String = #function,
                 line: Int = #line)
{
    #if DEBUG
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}


func method(){
    printLog("这是打印信息")
}


class MyClass {
   private(set) var name: String?
}


MyClass().name

method()

//闭包歧义

extension Int {
    func times(f:(Int)->Void){
        print("Int")
        for i in 1...self {
            f(i)
        }
    }
    
    func times(f: () -> Void) {
        print("Void")
        for _ in 1...self {
            f()
        }
    }
    
    func times(f: (Int, Int) -> ()) {
        print("Tuple")
        for i in 1...self {
            f(i, i)
        }
    }
    
    
}

3.times { i in
    print("\(i)")
}

3.times {
    print("1")
}

3.times { a, b in
    
}

//在这个定义中，已经声明了 Element 为泛型类型。在为类似这样的泛型类型写扩展的时候，我们 不需要在 extension 关键字后的声明中重复地去写 <Element> 这样的泛型类型名字

extension Array {
    var random: Element? {
        return self.count != 0 ? self[Int(arc4random_uniform(UInt32(self.count)))] : nil
    }
    
    func appendRandomDescription
    <U: CustomStringConvertible>(_ input: U) -> String {
        if let element = self.random {
            return "\(element) " + input.description
        } else {
            return "empty array"
        }
        
    }
    
}

let languages = ["Swift","ObjC","C++","Java"]
languages.random!

let ranks = [1,2,3,4]
ranks.random!

languages.appendRandomDescription(ranks.random!)


