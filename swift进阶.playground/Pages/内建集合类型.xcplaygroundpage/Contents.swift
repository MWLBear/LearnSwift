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

//map 的实现 泛型函数把for循环封装起来


/**
 数组和可变性
 
 数组是一个容器，它以有序的方式存储一系列相同 类型的元素，对于其中每个元素，我们可以使用下标对其直接进行访问 (这又被称作随机访问)。
 使用 let 定义的类实例对象 (也就是说对于引用类型) 时，它保 证的是这个引用永远不会发生变化，你不能再给这个引用赋一个新的值，但是这个引用所指向 的对象却是可以改变的
 
 
 */

let a = NSMutableArray(array: [1,2,3])
let b:NSArray = a
a.insert(4, at: 3)
b


let c = NSMutableArray(array: [1,2,3])
let d = c.copy() as! NSArray
c.insert(4, at: 3)
d


/**
 数组和可选值
 
 Swift 数组提供了你能想到的所有常规操作方法，像是 isEmpty 或是 count。数组也允许直接 使用特定的下标直接访问其中的元素，像是 􏰀bs[3]。不过要牢记在使用下标获取元素之前，你 需要确保索引值没有超出范围。
 
 
 fi􏰀rst 和 last 属性本身是可选值类型
 类似地，如果数组为空时，removeLast 将会导致崩溃，而 popLast 将在数组不为空时删除最后一个元素并返回它，在数组为空时，它将不执行任何操作， 直接返回 nil。
 
 */

/**
 数组和变形
 Map
 
 
 */


//map 的可能实现方式,把for循环用泛型函数封装起来
/**
Element 是数组中包含的元素类型的占位符，T 是元素转换之后的类型的占位符。map 函数本 身并不关心 Element 和 T 究竟是什么，它们可以是任意类型。T 的具体类型将由调用者传入给 map 的 transform 方法的返回值类型来决定。

*/

extension Array{
    
    func map_<T>(_ transform:(Element)->T) -> [T] {
        
        var result:[T] = []
        result.reserveCapacity(count)
        
        for x in self{
            result.append(transform(x))
        }
        return result
    }

}



let fibs = [0, 1, 1, 2, 3, 5]
let squares = fibs.map_ {$0*$0}
      
print(squares)

/**
 使用函数将行为参数化
 
 map 可以将模板代码分离出来，这些模板代码并不会随着每次调用发生变动，发生变动的是那 些功能代码，也就是如何变换每个元素的逻辑代码。map 函数通过接受调用者所提供的变换函 数作为参数来做到这一点。
 
 
 */

let names = ["Paula","Elena","Zoe"]
var lastNameEndingInA:String?

for name in names.reversed() where name.hasSuffix("a"){
    lastNameEndingInA = name
    break
}
lastNameEndingInA


//为Sequence 添加一个小扩展

extension Sequence{
    
    func last1(where predicate:(Element)->Bool) -> Element? {
        for element in reversed() where predicate(element){
            return element
        }
        return nil
    }
}

let match = names.last1 {$0.hasSuffix("a")}
match


/**
 可变和带有状态的闭包
 
 */

extension Array{
    
    func accumulate<Result>(_ initialResult:Result,_ nextPartialResult:(Result,Element)->Result) -> [Result] {
        
      
        var running = initialResult
       
        return map { next in
            running = nextPartialResult(running,next)
            return running
        }
        
    }
}

func myself(a:Int,b:Int)->Int{
    return a+b
}

// + 相当于 myself 函数

[1,2,3,4].accumulate(0, +)

/**
 
 Filter
 
 另一个常⻅操作是检查一个数组，然后将这个数组中符合一定条件的元素过滤出来并用它们创 建一个新的数组
 
 对数组进行循环并且根据条件过滤其中元素的模式可以用数组的 􏰀lter 方法
 */

let nums = [1,2,3,4,5,6,7,8,9,10]
let filternums = nums.filter{$0 % 2 == 0}
print(filternums)

let nus = (1..<10).map{$0*$0}.filter{$0 % 2 == 0}
print(nus)

//filter的实现

extension Array{
    
    func filter(_ isIncluded:(Element)->Bool) -> [Element] {
        var result:[Element] = []
        
        for x in self where isIncluded(x){
            result.append(x)
        }
        return result
    }
}

extension Sequence{
    public func all(matching predicate:(Element)->Bool)->Bool{
        return !contains{!predicate($0)}
    }
}

let evenNums = nums.filter { $0 % 2 == 0 } // [2, 4, 6, 8, 10]
evenNums.all { $0 % 2 == 0 } // true

/**
 Reduce

 map 和 􏰀lter 都作用在一个数组上，并产生另一个新的、经过修改的数组。不过有时候，你可 能会想把所有元素合并为一个新的值。
 
 */


var total = 0
for num in fibs{
    total = total+num
}
total

let sum = fibs.reduce(0, +)

//reduce 实现

extension Array{
    
    func reduce1<Result>(_ initialResult:Result,_ nextPartialResult:(Result,Element)->Result) -> Result {
        
        var result = initialResult
       
        //print("result:\(result)")
        
        for x in self{
//            print("x:\(x)")
            result = nextPartialResult(result,x)
        }
        
        return result
    }
    
}

let sum1 = fibs.reduce1(0, +)



//print("sum1: \(sum1)")


//使用 reduce 就能实现 map 和 fi􏰀lter

extension Array{
    
    func map2<T>(_ transform:(Element)->T) -> [T] {
        

        return reduce1([]){
            
           return $0 + [transform($1)]
        }
    }
    
    func filter2(_ isIncluded: (Element) -> Bool) -> [Element] {
        
        return reduce1([]) {
            
            isIncluded($1) ? $0 + [$1] : $0 }
    }
    
    func filter3(_ isInclude:(Element)->Bool) -> [Element] {
        return reduce(into:[]) { (reslut, element)  in
            if isInclude(element){
                reslut.append(element)
            }
        }
    }
    
    
    
    
}

let map2__ = fibs.map2{$0+1}

print("flibs:\(fibs)")
print("map2__ :\(map2__)")

/**
 
 f􏰁atMap
 有时候我们会想要对一个数组用一个函数进行 map，但是这个变形函数返回的是另一个数组， 而不是单独的元素。
 
 􏰁atMap 的函数签名看起来也和 map 基本一致，不过 􏰁atMap 变换函数返回的是一个数组。在 实现中，它使用的是 append(contentsOf:) 而不是 append(_:)
 */

func extractLinks(markdownFile: String) -> [URL]{
    return []
}

extension Array{
    
    func flatMap<T>(_ transform:(Element)->[T]) -> [T] {
        
        var result:[T] = []
        for x in self{
            result.append(contentsOf: transform(x))
        }
        return result
    }
}

//f􏰁atMap 的另一个常⻅使用情景是将不同数组里的元素进行合并。为了得到两个数组中元素的 所有配对组合
let suits = ["♠", "♥", "♣", "♦"]
let ranks = ["J","Q","K","A"]

let reslut = suits.flatMap { (suit) in
    
    ranks.map { (rank)  in
        (suit,rank)
    }
}
print(reslut)


/**
 使用 forEach 进行迭代
 
 */


for element in [1,2,3]{
//    print(element)
}

[1,2,3].forEach { (element) in
//    print(element)
}

extension Array where Element:Equatable{
    
    func index(of element:Element)-> Int?{
        for idx in self.indices where self[idx] == element {
            return idx
        }
        return nil
    }
}

//错误示范
//extension Array where Element:Equatable{
//    func index_foreach(of element:Element) -> Int? {
//        self.indices.filter { idx in
//            self[idx] == element
//        }.forEach { (idx) in
//            return idx
//        }
//        return nil
//    }
//}

(1..<10).forEach { (number) in
    print("forEach:\(number)")
    if number > 2{
        return
    }
}
//不过，因 为 return 在其中的行为不太明确，我们建议大多数其他情况下不要用 forEach。这种时候，使 用常规的 for 循环可能会更好。

/**
 
 数组类型
 
 切片:
 切片类型只是数组的一种表示方式，它背后的数据仍 然是原来的数组，只不过是用切片的方式来进行表示
 这意味着原来的数组并不需要被复制。 ArraySlice 具有的方法和 Array 上定义的方法是一致的，因此你可以把它当做数组来进行处理。 如果你需要将切片转换为数组的话，你可以通过把它传递给 Array 的构建方法来完成:

 
 */

let slice = fibs[1...]
slice
type(of: slice)
let newArry = Array(slice)
type(of: newArry)


/*
 字典
 字典包含键以及它们所对应的值
 通过键来获取值所花费的平均时间是常数量级的 (作为对比，在数组中搜寻 一个特定元素所花的时间将与数组尺寸成正比)
 字典是无序的
 
 
 **/

enum Setting{
    case text(String)
    case int(Int)
    case bool(Bool)
}

let defalutSettings:[String:Setting] = [
    "Airplane Mode":.bool(true),
    "Name":.text("My iPhone"),
]

defalutSettings["Name"]


