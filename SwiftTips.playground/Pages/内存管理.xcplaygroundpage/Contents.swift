//: [Previous](@previous)

import UIKit
class A: NSObject {
    let b: B
    override init() {
        b = B()
        super.init()
        b.a = self
    }
    deinit {
        print("A deinit")
    }
}

class B: NSObject {
    weak var a: A? = nil
    deinit {
        print("B deinit")
    }
}
//一般来说我们习惯希望“被动的一方”不要去持有“主动”的一方。
//在这里 b.a 里对 A 的实例的 持有是由 A 的方法设定的，我们在之后直接使用的也是 A 的实例，因此认为 b 是被动的一方

/**
 用通俗的话说，就是 unowned 设置以后即使它原来引用的内容已经被释放了，它仍然会保 持对被已经释放了的对象的一个 "无效的" 引用，它不能是 Optional 值，也不会被指向 nil 。如果 你尝试调用这个引用的方法或者访问成员属性的话，程序就会崩溃
 
 Apple 给我们的建议是如果能够确定在访问时不会已 被释放的话，尽量使用 unowned ，如果存在被释放的可能，那就选择用 weak 。
 
 */



var obj: A? = A()
obj = nil




//1.delegate

class RequestManager: RequestHandler{
    
    @objc func requestFinished() {
        print("请求完成")
    }
}

@objc protocol RequestHandler {
    @objc optional func requestFinished()
}

class Request {
    weak var delegate: RequestHandler!
    
    func send(){
        // 发送请求
    }
    func getResponse(){
        delegate?.requestFinished?()
    }
}

//闭包和循环引用


/**
 ，闭包中对任何其他元素的引用都是会被闭包 自动持有的。
 如果我们在闭包中写了 self 这样的东⻄的话，那我们其实也就在闭包内持有了当 前的对象。
 
 如果当前的实例直接或者间接地对 这个闭包又有引用的话，就形成了一个 self -> 闭包 -> self 的循环引用。
 
 
 */

class Person {
    let name: String
    lazy var printName:()->() = { [unowned self] in
//        if let strongSelf = self {
//            print("The name is \(strongSelf.name)")
//        }
//
        print("The name is \(self.name)")

    }
    init(personName: String){
        name = personName
    }
    
    deinit {
        print("Person deinit \(self.name)")
    }
}

//我们可以将上面的 weak 改为 unowned ，这样就不再需要 strongSelf 的判断。但是如果在过程中 self 被释放了而 printName 这个闭包没有被释放的话 ，使用 unowned 将造成崩溃

var xiaoming: Person? = Person(personName: "xiaoming")
xiaoming = nil
xiaoming?.printName()


//: [Next](@next)
