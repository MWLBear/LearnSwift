//: [Previous](@previous)

import Foundation


let diceFaceCount: UInt32 = 6
let randomRoll = Int(arc4random_uniform(diceFaceCount)) + 1
print(randomRoll)
print("-------------")
func random(in range:Range<Int>) -> Int {
    let count = UInt32(range.endIndex - range.startIndex)
    return Int(arc4random_uniform(count)) + range.startIndex
}

for _ in 1...100 {
    print(random(in: Range(1...6)))
}


//NSError

enum Result {
    case Sucess(String)
    case Error(NSError)
}

func doSomethingParam(_ param: AnyObject) -> Result {
    
    //...做某些操作，成功结果放在 success 中
    let sucess:Bool = true
    if sucess {
        return .Sucess("sucess")
    }else {
        let error = NSError(domain: "errDomain", code: 1, userInfo: nil)
        return .Error(error)
    }
}
class Path{}
let result = doSomethingParam(Path())

switch result {
case let .Sucess(ok):
    let serverResponse = ok
case  let .Error(error):
    let serverResponse = error.description
}


enum E: Error {
   case Negative
}
func methodThrowsWhenPassingNegative(number: Int) throws -> Int {
   if number < 0 {
       throw E.Negative
   }
   return number
}
if let num = try? methodThrowsWhenPassingNegative(number: 100) {
    print(type(of: num))
} else {
   print("failed")
}



//为了确保子类实现这些方法，而父类中的方法不被错误地调用，我们就可以 利用 fatalError 来在父类中强制抛出错误，以保证使用这些代码的开发者留意到他们必须在自己 的子类中实现相关方法:
class MyClass {
    func methodMustBeImplementedInSubclass() {
        fatalError("这个方法必须在子类中被重写")
    }
}
class YourClass: MyClass {
    override func methodMustBeImplementedInSubclass() {
        print("YourClass 实现了该方法")
    }
}
class TheirClass: MyClass {
    func someOtherMethod() {
    }
}

YourClass().methodMustBeImplementedInSubclass()
TheirClass().methodMustBeImplementedInSubclass()




//: [Next](@next)
