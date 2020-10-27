//
//  内建集合类型.swift
//  LearnSwift
//
//  Created by admin on 2020/9/15.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

/**
 
 专业术语:
 
 值 value,是不变的,永久的,它从不会改变
 
 var x = [1,2] 创建了名为x的变量(variable)来持有[1,2]这个值
 
 let 声明一个常量变量,简称常量,一旦常量被赋予一个值,就不能再次被赋予一个新的值了
 
 结构体和枚举都是值类型(value type)
 
 引用(reference) 是一种特殊的类型:它指向另一个值的值,两个引用可能会指向同一个值
 
 类(class)是引用类型(reference type),不能再一个变量里直接持有一个类的实例,对于一个类的实例
 ,我们只能在变量里持有对他的引用,然后通过这个引用来访问它
 
 引用类型具有同一性(identity),可以用 === 来检查两个变量是否引用了同一个对象
 
 == 结构相等 === 指针相等,或者应用相等

如果一个函数接受别的函数作为参数,或者一个函数的返回值是函数,这样的函数叫做高阶函数(higher-order function)
 
 如果一个函数被定义在外层作用域中,但是被传递出这个作用域(比如把这个函数作为其他函数的返回值返回时),它将能够捕获局部变量,
 这些局部变量将存在函数中,不会随局部变量的作用域的结束而消亡,函数持有他们的状态,这种行为的变量被称为"闭合变量",这样的函数叫做
 闭包(closure)
 
函数也可以通过{}这样简短的闭包表达式(closure expression)来定义,实际上使用 func 关键字定义的函数，如果它包含了外部的变量，那么 它也是一个闭包。
 
 函数是引用类型,
 
 定义在类或者协议中函数就是方法(method),他们有个隐式的self参数
 如果一个函数 不是接受多个参数，而是只接受部分参数，然后返回一个接受其余参数的函数的话，那么这个 函数就是一个柯里化函数 (curried function)
 不是方法的函数叫做自由函数(free function)
 
 在 Swift 中，一个完整的函数名字不仅仅只包括函数的基本名 (括号前面的部分)，也包括它的 参数标签 (argument label)。
 

 自由函数和那些在结构体上调用的方法是静态派发 (statically dispatched) 的。对于这些函数 的调用，在编译的时候就已经确定了。对于静态派发的调用，编译器可能能够内联 (inline) 这 些函数，也就是说，完全不去做函数调用，而是将函数调用替换为函数中需要执行的代码。优 化器还还能够帮助丢弃或者简化那些在编译时就能确定不会被实际执行的代码。
 
 
 类或者协议上的方法可能是动态派发 (dynamically dispatched) 的。编译器在编译时不需要知 道哪个函数将被调用。在 Swift 中，这种动态特性要么由 vtable 来完成，要么通过 selector 和 objc_msgSend 来完成，前者的处理方式和 Java 或是 C++ 中类似，而后者只针对 @objc 的类 和协议上的方法。
 
 

 子类型和方法重写 (overriding) 是实现多态 (polymorphic) 特性的手段，也就是说，根据类型 的不同，同样的方法会呈现出不同的行为。另一种方式是函数重载 (overloading)，它是指为不 同的类型多次写同一个函数的行为。
 */




class ______: NSObject {


    
/**
     数组和可变性:
     数组是一个容器，它以有序的方式存储一系列相同 类型的元素，对于其中每个元素，我们可以使用下标对其直接进行访问 (这又被称作随机访问)。
     */
    
    func arry_() {
        
        let a = NSMutableArray(array: [1,2,3])
        let b:NSArray = a
        a.insert(4, at: 3)
    
        print(b)
        let c = NSMutableArray(array: [1,2,3])

        let d = c.copy() as! NSArray
        c.insert(4, at: 3)
        
        print(d)
        
        let fibs = [0, 1, 1, 2, 3, 5]
        let squares = fibs.map {$0*$0}
        
        print(squares)
    }
    
    
}

//map 的实现 泛型函数把for循环封装起来
extension Array{
    
    func map<T>(_ transform:(Element)->T) -> [T] {
        
        var result:[T] = []
        result.reserveCapacity(count)
        
        for x in self{
            result.append(transform(x))
        }
        return result
    }
    
    
}
