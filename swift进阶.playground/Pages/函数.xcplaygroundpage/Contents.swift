//: [Previous](@previous)

import Foundation
import UIKit
import CoreLocation
import SafariServices

var str = "Hello, playground"
/**
 函数
 
 0. 函数可以像Int或者String那样被赋值给变量，也可以作为另一个函数的输入参数，或 者另一个函数的返回值来使用。
 1. 函数能够捕获存在于其局部作用域之外的变量。
 2. 有两种方法可以创建函数，一种是使用func关键字，另一种是{}。在Swift中，后一种
 被称为闭包表达式。
 
 
 */
// 1. 函数可以被赋值给变量，也能够作为函数的输入和输出
func printInt(i:Int){
    print("you passed:\(i)")
}

let funvar = printInt
funvar(2)

func useFunction(function:(Int)->()){
    function(3)
}

useFunction(function: printInt)
useFunction(function: funvar)

func returnFunc()->(Int)->String{
    
    func innerFunc(i:Int)->String{
        return "you passed\(i)"
    }
    return innerFunc
}

let myfunc = returnFunc()
myfunc(3)

//2. 函数可以捕获存在于它们作用范围之外的变量
//当函数引用了在函数作用域外部的变量时，这个变量就被 “捕获” 了，它们将会继续存在，而不 是在超过作用域后被摧毁。

func counterFunc()->(Int)->String{
    var count = 0
    func innerFunction(i:Int)->String{
        count += i
        return "running total:\(count)"
    }
    return innerFunction
}
let f = counterFunc()
f(3)
f(4)

let g = counterFunc()
g(2) // running total: 2
g(2) // running total: 4
//在编程术语里，一个函数和它所捕获的变量环境组合起来被称为闭包

//3. 函数可以使用 { } 来声明为闭包表达式
func doubler(i: Int) -> Int {
    return i*2
}
[1, 2, 3, 4].map(doubler) // [2, 4, 6, 8]

let doubleAlt = {(i:Int)->Int in return i*2}
[1,2,3,4].map(doubleAlt)

let isEven = { $0 % 2 == 0 }

extension BinaryInteger {
    var isEven: Bool { return self % 2 == 0 }
}

@objcMembers
final class Person:NSObject{
    let first:String
    let last:String
    let yearOfBirth:Int
    
    init(first:String,last:String,yearOfBirth:Int) {
        self.first = first
        self.last = last
        self.yearOfBirth = yearOfBirth
    }
}

let people = [
    Person(first: "Emily", last: "Young", yearOfBirth: 2002),
    Person(first: "David", last: "Gray", yearOfBirth: 1991),
    Person(first: "Robert", last: "Barnes", yearOfBirth: 1985),
    Person(first: "Ava", last: "Barnes", yearOfBirth: 2000),
    Person(first: "Joanne", last: "Miller", yearOfBirth: 1994),
    Person(first: "Ava", last: "Barnes", yearOfBirth: 1998),
]

let lastDescriptor = NSSortDescriptor(key: #keyPath(Person.last), ascending: true,
selector: #selector(NSString.localizedStandardCompare(_:)))

let firstDescriptor = NSSortDescriptor(key: #keyPath(Person.first),
ascending: true,selector: #selector(NSString.localizedStandardCompare(_:)))

let yearDescriptor = NSSortDescriptor(key: #keyPath(Person.yearOfBirth),
ascending: true)

let descriptors = [lastDescriptor, firstDescriptor, yearDescriptor]
let a = (people as NSArray).sortedArray(using: descriptors)
print(a)

var string =  ["Hello", "hallo", "Hallo", "hello"]

string.sort{$0.localizedStandardCompare($1) == .orderedAscending}
string
people.sorted { $0.yearOfBirth < $1.yearOfBirth }

//let s = ""
//
//var files = ["one", "file.h", "file.c", "test.h"]
//files.sort { l, r in r.fileExtension.flatMap {
//    l.fileExtension?.localizedStandardCompare($0) } == .orderedAscending
//
//}

people.sorted { p0, p1 in
    let left = [p0.last, p0.first]
    let right = [p1.last, p1.first]
    return left.lexicographicallyPrecedes(right) {
        $0.localizedStandardCompare($1) == .orderedAscending } //这个方法接受两个序列，并对它们执行一个电话簿方式的比较，也就是说，这个比较将 顺次从两个序列中各取一个元素来进行比较，直到发现不相等的元素。
}
people


//函数作为数据

/// ⼀一个排序断⾔，当且仅当第⼀一个值应当排序在第⼆二个值之前时，返回 `true`
typealias SortDescriptor<Value> = (Value,Value)->Bool

//排序描述符
let sortByYear:SortDescriptor<Person> = {$0.yearOfBirth<$1.yearOfBirth}
let sortByLantName:SortDescriptor<Person> = {$0.last.localizedStandardCompare($1.last) == .orderedAscending}


//这个函数接受一个键和一个比较函数，返回排序描述符 (这里的描述符将是函 数，而非 NSSortDescriptor)
//key 将不再是一个字符串，而它自身就是一个函数;给 定正在排序的数组中的一个元素，它就会返回这个排序描述符所处理的属性的值

func sortDescriptor<Value,Key>(key:@escaping(Value)->Key,by  areInIncreasingOrder:@escaping(Key,Key)->Bool)->SortDescriptor<Value>{
    return { areInIncreasingOrder(key($0), key($1)) }
}//key 函数描述了如何深入一个值，并提取出和一个特定的排序步骤相关的信息的方式。


let sortByYearAlt: SortDescriptor<Person> = sortDescriptor(key: { $0.yearOfBirth }, by: <)
let sortbBY:SortDescriptor<Person> = sortDescriptor(key: { c  in
    return c.yearOfBirth
}) { (a, b) -> Bool in
    return a<b
}

people.sorted(by: sortByYearAlt)

func sortDescriptor<Value, Key>(key: @escaping (Value) -> Key) -> SortDescriptor<Value> where Key: Comparable
{
    return { key($0) < key($1) }
}

let sortByYearAlt1: SortDescriptor<Person> = sortDescriptor(key: { $0.yearOfBirth })


func sortDescriptor<Value,Key>(
    key:@escaping(Value)->Key,
    ascending:Bool = true,
    by comparator:@escaping (Key)->(Key)->ComparisonResult)
    ->SortDescriptor<Value>{
                
        return { lhs, rhs in

            comparator
            let order: ComparisonResult = ascending ? .orderedAscending
                : .orderedDescending
            return comparator(key(lhs))(key(rhs)) == order }
}

let sortByFirstName: SortDescriptor<Person> =
    sortDescriptor(key: {$0.first}, by: String.localizedCompare)

people.sorted(by: sortByFirstName)


func combine<Value>(sortDescriptors:[SortDescriptor<Value>])->SortDescriptor<Value>{
    
    return {lhs,rhs in
        for areInIncreasingOrder in sortDescriptors{
            if areInIncreasingOrder(lhs,rhs) {return true}
            if areInIncreasingOrder(rhs,lhs) {return true}
        }
        return false
    }
}

let combined:SortDescriptor<Person> = combine(sortDescriptors:[sortByLantName,sortByFirstName,sortByYear])
people.sorted(by: combined)

//这种方式的实质是将函数用作数据，我们将这些函数存储在数组里，并在运行时构建这个数组。 这将动态特性带到了一个新的高
//我们也看到了合并其他函数的函数的用武之地，它也是函数式编程的构建模块之一

infix operator <||>:LogicalConjunctionPrecedence
func <||><A>(lhs:@escaping(A,A)->Bool,rhs:@escaping(A,A)->Bool)->(A,A)->Bool{
    
    return{x,y in
        if lhs(x,y) {return true}
        if lhs(y,x) {return false}
        if rhs(x,y) {return true}
        return false
    }
}
for x in stride(from: 0, to: 10, by: 1) {
    print(x)
}


//局部函数和变量捕获

extension Array where Element:Comparable{
    private mutating func merge(lo:Int,mi:Int,hi:Int){
        
        //[1,4,2,9]
        print("lo:\(lo),mi:\(mi),hi:\(hi)")
        
        var temp:[Element] = []
        var i = lo,j = mi
        while i != mi && j != hi {
            if self[j]<self[i] {
                temp.append(self[j])
                j += 1
            }else{
                temp.append(self[i])
                i += 1
            }
        }
        print("temp0:\(temp)")
        temp.append(contentsOf: self[i..<mi])
        temp.append(contentsOf: self[j..<hi])
        print("temp:\(temp)")
        replaceSubrange(lo..<hi, with: temp)
        print("self:\(self)")
    }
    
    mutating func mergeSortInPlaceInefficient() {
        let n = count
        var size = 1
        while size<n{
            for lo in stride(from: 0, to: n-size, by: size*2) { //返回从起始值到但不包括结束值的序列，以指定的数量为步长
                print("lo-----:\(lo)")
                merge(lo: lo, mi: (lo+size),hi: Swift.min(lo+size*2,n))
            }
            size *= 2
        }
    }
}


for s in stride(from: 0, to: 2, by: 4)
{
    print("s:\(s)")
}

var aas = [1,4,9,3]
aas.mergeSortInPlaceInefficient()

//函数作为代理

protocol AlertViewDelegate{
   mutating func buttonTapped(atIndex:Int)
}

class AlertView {
    var buttons:[String]
    //var delegate:AlertViewDelegate?
    var buttonTapped:((_ buttonIndex:Int)->())?
    
    init(buttons:[String] = ["OK","Cancle"]) {
        self.buttons = buttons
    }
    func fire() {
        //delegate?.buttonTapped(atIndex: 1)
        buttonTapped?(2)
    }
}


class ViewController{
    let alert:AlertView
    init() {
        alert = AlertView(buttons: ["OK","Cancle"])
        
        alert.buttonTapped = {[weak self] index in
            self?.buttonTapped(atIndex: index)
        }
    }

    func buttonTapped(atIndex index: Int) {
        print("bttons tapped:\(index)")
    }
}

struct TapLogger {

    var taps: [Int] = []

    mutating func logTap(index:Int){
        taps.append(index)
    }
}

let alert = AlertView()
var logger = TapLogger()
let vc = ViewController()
vc.alert.fire()

alert.buttonTapped =  { logger.logTap(index: $0) }
//alert.buttonTapped = { print("Button \($0) was tapped") }
alert.fire()
logger.taps
//inout 参数和可变方法
/**
 inout 做的事情是通过值传递，然后复制回来，而并不 是传递引用。
 inout 参数将一个值传递给函数，函数可以改变这个值，然后将原来的值替换掉，并 从函数中传出。
 
 
 我们需要对 lvalue 和 rvalue 进行区 分。lvalue 描述的是一个内存地址，它是 “左值 (left value)” 的缩写，因为 lvalues 是可以存在 于赋值语句左侧的表达式
 而 rvalue 描述的是一个值。
 对于 inout 参数，你只能传递 lvalue 给他，
 
 对于所有的下标 (包括你自定义的那些下标)，只有它同时拥有 get 和 set 两个方法， 这都是适用的。
 如果一个属性是只读的 (也就是说，只有 get 可用)，我们将不能将其用于 inout 参数:
 运算符也可以接受 inout 值
 
 编译器可能会把 inout 变量优化成引用传递，而非传入和传出时的复制。不过，文档已经明确 指出了我们我们不应该依赖 inout 的这个行为。
 
 */

func increment(value:inout Int){
    value += 1
}
var i = 0
increment(value: &i)
var array = [0, 1, 2]
increment(value: &array[0])
array

//嵌套函数和inout

func incrementTenTimes(value: inout Int){
    func inc(){
        value += 1
    }
    for _ in 0..<10{
        inc()
    }
}
var x = 0
incrementTenTimes(value: &x)

//不能够让这个 inout 参数逃逸
//func escapeIncrement( value: inout Int) -> () -> () {
//    func inc() {
//        value += 1
//    }
//// error: 嵌套函数不不能捕获 inout 参数
//    return inc
//}

/**
 计算属性
计算属性看起来和常规 的属性很像，但是它并不使用任何内存来存储自己的值。相反，这个属性每次被访问时，返回 值都将被实时计算出来。下标的话，就是一个遵守特殊的定义和调用规则的方法。
 
 */

struct GPSTrack{
   private(set) var record:[(CLLocation,Date)] = [] //外部只读，内部可读写的话
    
}
extension GPSTrack{
    var timestamps:[Date] {
        return record.map{$0.1}
    }
}

class CPSTrackViewController:UIViewController{
    var track:GPSTrack = GPSTrack()
    lazy var preview:UIImage = {
        for point in track.record{
            //复杂计算
        }
        return UIImage(named: "")!
    }()
}

//下标

extension Collection{
    subscript(indices indexList:Index...)->[Element]{
        var reslut : [Element] = []
        for index in indexList{
            reslut.append(self[index])
        }
        return reslut
    }
}

Array("adfasdfadfadagaeregf")[indices:5,3,6,7]

//下标进阶


//键路径
/**
 键路径是一个指向属性的未调用的引用，它和对某个方法的未 使用的引用很类似
 键路径描述了一个值从根开始的层级路径
 */

struct Address{
    var street:String
    var city:String
    var zipCode:Int
}

struct Person0 {
    let name:String
    var adress:Address

}

let streetKeyPath = \Person0.adress.street
let nameKeyPath = \Person0.name

let simpsonResidence = Address(street: "102 tan cun lu", city: "guang zhou", zipCode: 97133)
var lisa = Person0(name: "zhang fei", adress: simpsonResidence)
lisa[keyPath:nameKeyPath]
lisa[keyPath:streetKeyPath]
lisa[keyPath: streetKeyPath] = "103 tan cun lu"

//func sortDescriptor111<Value, Key>(key: @escaping (Value) -> Key)
//    -> SortDescriptor<Value> where Key: Comparable {
//        return { key($0) < key($1) }
//
//}
//let streetSD: SortDescriptor<Person0> = sortDescriptor111{ $0.address.street }


func sortDescriptor<Value, Key>(key: KeyPath<Value, Key>) -> SortDescriptor<Value> where Key: Comparable {
    return { $0[keyPath: key] < $1[keyPath: key] }
}
let streetSDKeyPath: SortDescriptor<Person0> = sortDescriptor(key: \.adress.street)

//可写键路径

//let streetKeyPath = \Person0.adress.street

let getStreet:(Person0)->String = {person in
    return  person.adress.street
}
let setStreet:(inout Person0,String)->() = {person,newValue in
    person.adress.street = newValue
}

lisa[keyPath:streetKeyPath]
getStreet(lisa)

//键路径实现双向绑定



//每当 self 上 的被观察值变更，我们就同时变更另一个对象。
extension NSObjectProtocol where Self:NSObject{
    
    func observe<A,Other>(_ keyPath:KeyPath<Self,A>,writeTo other:Other,_ otherKeyPath:ReferenceWritableKeyPath<Other,A>) -> NSKeyValueObservation where A:Equatable,Other:NSObjectProtocol{
        
        return observe(keyPath, options: .new) { (_  , change) in
            guard let newValue = change.newValue,other[keyPath:otherKeyPath] !=  newValue else {
                return
            }
            other[keyPath:otherKeyPath] = newValue
        }
    }
}


//双向绑定
extension NSObjectProtocol where Self:NSObject{
    func bind<A,Other>(_ keyPath:ReferenceWritableKeyPath<Self,A>,
                       to other:Other,
                       _ otherKeyPath:ReferenceWritableKeyPath<Other,A>)
        ->(NSKeyValueObservation,NSKeyValueObservation)
        where A:Equatable,Other:NSObject{
            
            let one = observe(keyPath, writeTo: other, otherKeyPath)
            let two = other.observe(otherKeyPath, writeTo: self, keyPath)
            return(one,two)
    }
}

final class Sample: NSObject {
    @objc dynamic var name: String = ""
}
class MyObj: NSObject {
    @objc dynamic var test: String = ""
}

let sample = Sample()
let other = MyObj()
let observation = sample.bind(\Sample.name, to: other, \.test)

sample.name = "New"
other.test

other.test = "HJ"
sample.name

/**
 键路径层级
 
 
 */
