//: [Previous](@previous)

import Foundation
import UIKit

//面向协议编程

protocol Drawing{
    mutating func addEllipse(rect:CGRect,fill:UIColor)
    mutating func addRectangle(rect:CGRect,fill:UIColor)
    
}
extension CGContext:Drawing{
    func addEllipse(rect: CGRect, fill: UIColor) {
        setFillColor(fill.cgColor)
        fillEllipse(in: rect)
    }
    func addRectangle(rect: CGRect, fill fillColor: UIColor) {
        setFillColor(fillColor.cgColor)
        fill(rect)
    }
}



struct SVG{
    
    var rootNode:[String] = []
    mutating func append(node:String    ){
        rootNode.append(node)
    }
}

extension SVG:Drawing{
    mutating func addRectangle(rect: CGRect, fill: UIColor) {
        
        append(node: "rect")
    }
    mutating func addEllipse(rect: CGRect, fill: UIColor) {
        append(node: "ellipse")
    }
}

var context:Drawing = SVG()
let rect1 = CGRect(x: 0, y: 0, width: 100, height: 100)
let rect2 = CGRect(x: 0, y: 0, width: 50, height: 50)
context.addEllipse(rect: rect1, fill: .yellow)
context.addRectangle(rect: rect2, fill: .yellow)

context.self

extension Drawing{
    mutating func addCircle(){
        print("Drawing addCircle")
    }
}

extension SVG{
    mutating func addCircle() {
        print("SVG addCircle")
    }
}

var sample = SVG()
sample.addCircle()

//还可以在协议定义本身中添加这个方法的声明，让它成为协议要求的方法。协议要求的方法是动态派发的，而仅定义在扩展中 的方法是静态派发的
//在协议中定义的方法是动态派发的，在协议拓展中实现方法（没有在协议主体中声明的）是静态派发。

//动态派发指的是在变量具体是哪一种类型，就到具体的类型中找方法的实现（不在乎声明变量时候 声明的是什么类型），如果有就调用，如果没有再去调协议拓展中的实现。静态派发指的是 变量声明时候指定的是哪一种类型，就到这个类型中去找方法的实现，即使它的实际类型有其他的实现，也不会去调用。



//编译器会自动将 SVG 值封装到一个代表协议的类型中，这个封装被称作存在容器
//当我们对存在容器调用 addCircle 时，方法是静态派发
var otherSample:Drawing = SVG()
otherSample.addCircle()

//例子
protocol Fruit{
    func ripe()
}

extension Fruit{
    func ripe(){
        print ("Fruit ripe.")
    }
    func name(){
        print("Fruit")
    }
}

struct Banana : Fruit{
    func ripe(){
        print ("Banana ripe.")
    }
    func name(){
        print("Banana")
    }
}
let a : Fruit = Banana()
let b : Banana = Banana()

a.ripe()
b.ripe()
a.name()
b.name()

struct ConstantIterator: IteratorProtocol {
    mutating func next() -> Int? {
return 1 }
}

//class IntIterator {
//    var nextImpl: () -> Int?
//    init<I: IteratorProtocol>(_ iterator: I) where I.Element == Int {
//        var iteratorCopy = iterator
//        self.nextImpl = { iteratorCopy.next() }
//    }
//}
//var iter = IntIterator(ConstantIterator())
//iter = IntIterator([1,2,3].makeIterator())
//
//extension IntIterator: IteratorProtocol {
//    func next() -> Int? {
//        return nextImpl() }
//}
//
//class AnyIterator<A>: IteratorProtocol {
//
//    var nextImpl: () -> A?
//    init<I: IteratorProtocol>(_ iterator: I) where I.Element == A {
//        var iteratorCopy = iterator
//        self.nextImpl = { iteratorCopy.next() }
//    }
//    func next() -> A? {
//        return nextImpl()
//    }
//}
//class IteratorBox<Element>: IteratorProtocol {
//    func next() -> Element? {
//        fatalError("This method is abstract.")
//    }
//}
//
//class IteratorBoxHelper<I: IteratorProtocol> {
//    var iterator: I
//    init(iterator: I) {
//        self.iterator = iterator
//    }
//    func next() -> I.Element? {
//        return iterator.next()
//    }
//}

//协议内幕

func f<C:CustomStringConvertible>(_ x:C)->Int{
    return MemoryLayout.size(ofValue: x)
}

func g(_ x:CustomStringConvertible)->Int{
    return MemoryLayout.size(ofValue: x)
}

f(5)
g(5)

/**
对于普通的协议  会使用不透明存在容器 (opaque existential container)
 
 不透明存在容器中含有:
 一 个存储值的缓冲区 (大小为三个指针，也就是 24 字节)
 一些元数据 (一个指针，8 字节);
 以及 若干个目击表 (0 个或者多个指针，每个 8 字节)
 
 如果值无法放在缓冲区里，那么它将被存储到 堆上，缓冲区里将变为存储引用，它将指向值在堆上的地址
 元数据里包含关于类型的信息 (比 如是否能够按条件进行类型转换等)。
 

 目击表是让动态派发成为可能的关键
 它为一个特定的类型将协议的实现进行编码:对于协议 中的每个方法，表中会包含一个指向特定类型中的实现的入口。有时候这被称为 vtable。

 不透明存在容器的尺寸取决于目击表个数的多少，每个协议会对应一个目击表
 
 
 
 
 
 
 */









