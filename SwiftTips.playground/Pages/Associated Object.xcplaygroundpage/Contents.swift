//: [Previous](@previous)

import Foundation

class MyClass { }
private var key: Void?

extension MyClass {
    var title:String? {
        get {
            return objc_getAssociatedObject(self, &key) as? String
        }
        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

func printTitle(_ input: MyClass){
    if let title = input.title {
        print("Tilte:\(title)")
    }else {
        print("没有设置")
    }
}


let a = MyClass()
printTitle(a)

a.title = "Swifter.tips"
printTitle(a)


func synchronized(_ lock: AnyObject, closure: () -> ()) {
   objc_sync_enter(lock)
   closure()
   objc_sync_exit(lock)
}
// 一个实际的线程安全的 setter 例子

class Obj {
    var _str = "123"
    var str: String {
        
        get {
            return _str
        }
        
        set {
            synchronized(self) {
                _str = newValue
            }
        }
    }
    
}

//: [Next](@next)
