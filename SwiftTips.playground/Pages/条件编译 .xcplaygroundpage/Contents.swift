//: [Previous](@previous)

import UIKit



// MARK
// TODO: 和 // FIXME

#if os(macOS)
    typealias Color = NSColor
#else
    typealias Color = UIColor
#endif


class 我的类:NSObject {
    func 打招呼(名字:String){
        print("哈喽\(名字)")
    }
}
我的类().打招呼(名字: "小明")

/**
 在 Swift 类型 文件中，我们可以将需要暴露给 Objective-C 使用的任何地方 (包括类，属性和方法等) 的声明前 面加上 @objc 修饰符
 
 Objective-C 的话是无法使用中文来进行调用的，因此我们必须使用 @objc 将其转为 ASCII 才能 在 Objective-C 里访问:
 
 
 */
//: [Next](@next)
