//: [Previous](@previous)
import Foundation

/**
 
 
 序列
 Sequence协议是集合类型结构的基础,一个序列 (sequence) 代表的是一系列具有相同类型 的值，你可以对这些值进行迭代
 满足 Sequence 协议的要求十分简单，你需要做的所有事情就是提供一个返回迭代器 (iterator) 的 makeIterator() 方法:
 
 我们现在只能从 Sequence 的 (这个简化后的) 定义中知道它是一个可以创建迭代 器 (Iterator) 协议的类型
 
 */



//protocol Sequence{
//
//    associatedtype Iterator:IteratorProtocol
//
//    func makeIterator()->Iterator
//
//
//}


/**
 
 迭代器
 
 
 序列通过创建一个迭代器来提供对元素的访问
 
 迭代器每次产生一个序列的值，并且当遍历序 列时对遍历状态进行管理。在 IteratorProtocol 协议中唯一的一个方法是 next()，这个方法需 要在每次被调用时返回序列中的下一个值。当序列被耗尽时，next() 应该返回 nil:
 
 迭代器是单向结构，它只能按照增加的方向前进，而不能倒退或者重置
 
 迭代器的本质是存在状态的。几乎所有有 意义的迭代器都会要求可变状态，这样它们才能够管理在序列中的当前位置。
 
 */



//protocol IteratorProtocol{
//
//    associatedtype Element
//    mutating func next()->Element?
//}

//不断返回值的迭代器
struct Constantlterator:IteratorProtocol{
    
//    typealias Element = Int
    mutating func next() -> Int? {
        return 1
    }
}

//var iterator = Constantlterator()
//
//while let x = iterator.next()  {
//    print(x)
//}


//FibsIterator 迭代器可以产生一个斐波那契序列,这个迭代器也将产生 “无穷” 的数字
struct FibsIterator:IteratorProtocol{
    var state = (0,1)
    
    mutating func next() -> Int? {
        let upcomingNumber = state.0
        state = (state.1,state.0+state.1)
        return upcomingNumber
    }
}

//遵守序列协议
//有限序列的迭代器
struct PrefixIterator:IteratorProtocol{
    
    let string:String
    var offset:String.Index
    
    init(string:String) {
        self.string = string
        offset = string.startIndex
    }
    
    
    mutating func next() -> Substring? {
        guard offset<string.endIndex else {
            return nil
        }
        offset = string.index(after: offset)
        return string[..<offset]
    }
    
}


struct PrefixSequence:Sequence{
        
    let string:String
    func makeIterator() -> PrefixIterator {
        return PrefixIterator(string: string)
    }
   
   
}


for x in PrefixSequence(string: "Hello"){
    print(x)
}


let pre = PrefixSequence(string: "Hello").map{$0.uppercased()}


struct Countdown: Sequence, IteratorProtocol {
    var count: Int
 
    mutating func next() -> Int? {
        if count == 0 {
            return nil
        } else {
            defer { count -= 1 }
            return count
        }
    }
}
 
let threeToGo = Countdown(count: 3)
for i in threeToGo {
    print(i)
}

//迭代器和值语义

/*
 我们至今为止所看到的迭代器都具有值语义。如果你复制一份，迭代器的所有状态也都会被复 制，
 这两个迭代器将分别在自己的范围内工作，这是我们所期待的。
 标准库中的大部分迭代器 也都具有值语义，不过也有例外存在。
 
 
 你只用它来循环元素，然后就将其抛弃。如果你发现你要与其他对象共享一个迭代器的话，可以考虑将它封装到 序列中，而不是直接传递它。

 **/

let seq = stride(from: 0, to: 10, by: 1)
var i1 = seq.makeIterator()
print(i1.next())
print(i1.next())
var i2 = i1
print(i1.next())
print(i1.next())
print(i2.next())
print(i2.next()) //StrideToIterator值语义

//AnyIterator 是一个对别的迭代器进行封装的 迭代器，它可以用来将原来的迭代器的具体类型 “抹消” 掉。
//AnyIterator 进行封装的做法是将另外的迭代器包装到一个内部的对象中，而这个对象是引 用类型。
// 协议类型抹除?
//AnyIterator 还有另一个初始化方法，那就是直接接受一个 next 函数作为参数。与对应的 AnySequence 类型结合起来使用，我们可以做到不定义任何新的类型，就能创建迭代器和序 列


var i3 = AnyIterator(i1)
var i4 = i3

print(i3.next())
print(i4.next())
print(i3.next())
print(i3.next())

//基于函数的迭代器和序列



func fibsIterator()->AnyIterator<Int>{ // AnyIterator 定义的没有的没有值语义
    var state = (0,1)
    return AnyIterator {
        let upconmingNumber = state.0
        state = (state.1,state.0+state.1)
        return upconmingNumber
    }
    
}

let fibsSeque = AnySequence(fibsIterator)
let f = Array(fibsSeque.prefix(10))
print(f)


//sequence 函数，这个函数有两种版本。第一种版本，sequence(􏰀rst:next:) 将使用第一个参数的值作为序列的首个元素，并使用 next 参数传入的闭包生成序列的后续元 素，最后返回生成的序列。另一个版本是 sequence(state:next:)，因为它可以在两次 next 闭 包被调用之间保存任意的可变状态，所以它更强大一些。通过它，我们可以只进行一次方法调 用就构建出斐波纳契序列

let fibsSeque2 = sequence(state:(0,1)) { (state:inout(Int,Int)) -> Int? in
    let upcomingNumber = state.0
    state = (state.1,state.0+state.1)
    return upcomingNumber
}
Array(fibsSeque2.prefix(10))
//sequence(􏰀rst:next:) 和 sequence(state:next:) 的返回值类型是 UnfoldSequence。 这个术语来自函数式编程，在函数式编程中，这种操作被称为展开 (unfold)。sequence 是和 reduce 对应的 (在函数式编程中 reduce 又常被叫做 fold)。reduce 将一个序列 缩减 (或者说折叠) 为一个单一的返回值，而 sequence 则将一个单一的值展开形成一 个序列。



/**无限序列
sequence 对于 next 闭包的使用是被延迟的。
 也就是说， 序列的下一个值不会被预先计算，它只在调用者需要的时候生成
 如果序列是主动计算它的所有值的话，因为序列是无限的，程序将会在有机会执行下 一步之前就因为整数溢出的问题而发生崩溃。
  对于序列和集合来说，它们之间的一个重要区别就是序列可以是无限的，而集合则不行。
 
 
 不稳定序列
 序列并不只限于像是数组或者列表这样的传统集合数据类型。像是网络流，磁盘上的文件，UI 事件的流，以及其他很多类型的数据都可以使用序列来进行建模。但
 但是这些都和数组不太一样， 对于数组，你可以多次遍历其中的元素，而上面这些例子中你并非对所有的序列都能这么做。
 
 斐波纳契序列确实不会因为遍历其中的元素而发生改变，你可以从 0 开始再次进行遍历，但是 像是网络包的流这样的序列将会随着遍历被消耗。你就算再次对其进行迭代，它也不会再次产 生同样的值。
 
 Sequence 协议并不关心遵守该协议的类型是否会在迭代后将序列的元素销毁。
 也就 是说，请不要假设对一个序列进行多次的 for-in 循环将继续之前的循环迭代或者是从 头再次开始
 一个非集合的序列可能会在第二次 for-in 循环时产生随机的序列元素。
 
只有 Collection 协议能保证多 次进行迭代是安全的，Sequence 中对此并没有进行保证。
 
 

 如果你在写一个 Sequence 的扩展的话，你并不需要考虑这个序列在迭代时是不是会被破坏。
 但是如果你是一个序列类型上的方法的调用者，你应该时刻提醒自己注意访问的破坏性。
 
*/




/**序列和迭代器之间的关系
 
 
 
 
 
 
 */

/**子序列 Sequence 还有另外一个关联类型，叫做 SubSequence:
 
 在返回原序列的切片的操作中，SubSequence 被用作返回值的子类型，这类操作包括:
 → pre􏰀x和suf􏰀x—获取开头或结尾n个元素
 → pre􏰀x(while:)-从开头开始当满足条件时，
 → dropFirst和dropLast—返回移除掉前n个或后n个元素的子序列 → drop(while:)-移除元素，直到条件不再为真，然后返回剩余元素
 → split—将一个序列在指定的分隔元素时截断，返回子序列的的数组

 
 */


extension Sequence where Element: Equatable
{
    func headMirrorsTail(_ n: Int) -> Bool {
        
        let head = prefix(n)
        let tail = suffix(n).reversed()
        return head.elementsEqual(tail)
    }
    
}

[1,2,3,4,2,1].headMirrorsTail(2) // true


/**链表
 单向链表。一个链 表的节点有两种可能:要么它是一个节点，其中包含了值及对下一个节点的引用，要么它代表 链表的结束。
 
 */

enum List<Element>{
    case end
    indirect case node(Element,next:List<Element>) //在这里使用 indirect 关键字可以告诉编译器这个枚举值 node 应该被看做引用。
}

let emptyList = List<Int>.end
let oneElementList = List.node(1, next: emptyList)

print(oneElementList)

extension List{
    
    // 在链表前⽅方添加⼀一个值为 `x` 的节点，并返回这个链表
    func cons(_ x:Element) -> List {
        return .node(x, next: self)
    }
}

// ⼀一个拥有 3 个元素的链表 (3 2 1)
let list = List<Int>.end.cons(1).cons(2).cons(3)

print(list)

//用数组字面量的方式来初始化一个链表
extension List:ExpressibleByArrayLiteral{
    init(arrayLiteral elements: Element...) {
        self = elements.reversed().reduce(.end){partiaList,element in
            partiaList.cons(element)
        }
    }
}

let list2:List = [3,2,1]
print(list2)



extension List{
    mutating func push(_ x:Element){
        self = self.cons(x)
    }
    mutating func pop()->Element?{
        switch self {
        case .end: return nil
        case let .node(x, next: tail):
            self = tail
            return x
        }
    }
    
}

var stack: List<Int> = [3,2,1]
var a = stack
var b = stack


a.pop()
a.pop()
a.pop()

stack.pop()
stack.push(4)

b.pop()
b.pop()
b.pop()

stack.pop()
stack.pop()
stack.pop()

//链表迭代器 让List 遵守 Sequence
extension List:IteratorProtocol,Sequence{
    
    mutating func next() -> Element? {
        return pop()
    }
}
let list1: List = ["1", "2", "3"]

for x in list1{
    //print("\(x) ", terminator: "")
}
list1.joined(separator: ",")
list1.contains("2")
list1.flatMap{Int($0)}
list1.elementsEqual(["1","2","3"])






/**集合类型
 集合类型 (Collection) 指的是那些稳定的序列，它们能够被多次遍历且保持一致
 除了线性遍 历以外，集合中的元素也可以通过下标索引的方式被获取到。下标索引通常是整数，至少在数 组中是这样。
 集合的索引值可以构成一个有限的范围，它具有定义好了的 开始和结束索引。也就是说，和序列不同，集合类型不能是无限的。
 
 Collection 协议是建立在 Sequence 协议上的
 
 
 */

//自定义的集合类型

/// 为队列设计协议: ⼀一个能够将元素⼊入队和出队的类型
protocol Queue{
    /// 在 `self` 中所持有的元素的类型
    associatedtype Element
    /// 将 `newElement` ⼊入队到 `self`
    mutating func enqueue(_ newElement:Element)
    /// 从 `self` 出队⼀一个元素
    mutating func dequeue()->Element?
}

/// ⼀一个⾼高效的 FIFO 队列列，其中元素类型为 `Element`
struct FIFOQueue<Element>:Queue{
    
    private var left:[Element] = []
    private var right:[Element] = []
    
    // 将元素添加到队列列最后
    /// - 复杂度: O(1)
    mutating func enqueue(_ newElement: Element) {
        right.append(newElement)
    }
    
    /// 从队列列前端移除⼀一个元素
    /// 当队列列为空时，返回 nil
    /// - 复杂度: 平摊 O(1)
    mutating func dequeue() -> Element? {
        
        if left.isEmpty{
            left = right.reversed()
            right.removeAll()
        }
        
        return left.popLast()
    }
    
}


// 要使你的类型满足 Collection，你至少需要声明以下要求的内容:
    // → startIndex和endIndex属性
    // → 至少能够读取你的类型中的元素的下标方法
    // → 用来在集合索引之间进行步进的index(after:)方法。

//遵守 Collection 协议
extension FIFOQueue:Collection{
    
    /// ⼀一个⾮非空集合中⾸首个元素的位置
    public var startIndex: Int{return 0}
    
    /// 集合中超过末位的位置---也就是⽐比最后⼀一个有效下标值⼤大 1 的位置
    public var endIndex: Int{return left.count+right.count}
    
    /// 返回在给定索引之后的那个索引值
    public func index(after i: Int) -> Int {
        precondition(i<endIndex)
        return i+1
    }
    
    /// 访问特定位置的元素
    public subscript(position: Int) -> Element {
        precondition((0..<endIndex).contains(position),"Index out of bounds")
        if position<left.endIndex{
        //[3,2][4]
            return left[left.count - position - 1]
        }else{
            return right[position-left.count]
        }
    }
    
    //索引是整数类型，
    typealias Indices = CountableRange<Int>
    var indices: CountableRange<Int>{
        return startIndex..<endIndex
    }
    
}


var q = FIFOQueue<String>()
for x in ["1","2","foo","3"]{
    q.enqueue(x)
}

for s in q{
    print("s: \(s)")
}

var a1 = Array(q)
a1.append(contentsOf: q[2...3])
a1

q.map{$0.uppercased()}
q.flatMap { Int($0) } // [1, 2, 3]
q.filter { $0.count > 1 } // ["foo"]
q.sorted() // ["1", "2", "3", "foo"]
q.joined(separator: " ") // 1 2 foo 3
q.isEmpty
q.count
q.first



//遵守 ExpressibleByArrayLiteral 协议
extension FIFOQueue:ExpressibleByArrayLiteral{
    public init(arrayLiteral elements: Element...) {
        left = elements.reversed()
        right = []
    }
}


let queue:FIFOQueue = [1,2,3]

queue.index(after: 1)



//索引
/**

 索引表示了集合中的位置。每个集合都有两个特殊的索引值，startIndex 和 endIndex。
 startIndex 指定集合中第一个元素，endIndex 是集合中最后一个元素之后的位置
 
 索引应该是一个只存储包含描述元素位置所需最小信息的简单值
 
 */

/**自定义集合索引*/


extension Substring{
    
    var nextWordRange:Range<Index>{
        let start = drop(while: {$0 == " "})
        let end = start.index(where:{$0 == " "}) ?? endIndex
        return start.startIndex..<end
    }
    
}


struct WordsIndex:Comparable{
    
    fileprivate let range:Range<Substring.Index>
    fileprivate init(_ value:Range<Substring.Index>){
        self.range = value
    }
    static func <(lhs: Words.Index, rhs: Words.Index) -> Bool {
        return lhs.range.lowerBound < rhs.range.lowerBound
    }
    static func ==(lhs: Words.Index, rhs: Words.Index) -> Bool {
        return lhs.range == rhs.range
    }
}

struct Words:Collection{
   
    let string:Substring
    let startIndex:WordsIndex
    
    init(_ s:String) {
        self.init(s[...])
    }
    
    private init(_ s:Substring){
        self.string = s
        self.startIndex = WordsIndex(string.nextWordRange)
    }
    
    var endIndex: WordsIndex {
        let e = string.endIndex
        return WordsIndex(e..<e)
    }
}
extension Words{
    subscript(index:WordsIndex)->Substring{
        return string[index.range]
    }
    
    subscript(range:Range<WordsIndex>)->Words{
        let start = range.lowerBound.range.lowerBound
        let end = range.upperBound.range.upperBound
        return Words(string[start..<end])
    }
}
extension Words{
    func index(after i: WordsIndex) -> WordsIndex {
        guard i.range.upperBound < string.endIndex else{
            return endIndex
        }
        let remainder = string[i.range.upperBound...]
        return WordsIndex(remainder.nextWordRange)
    }
}

Array(Words("hello world text")).prefix(2)


let words:Words = Words("one two there")
let onePastStart = words.index(after: words.startIndex)
let firstDropped = words[onePastStart..<words.endIndex]
Array(firstDropped)




struct PrefixIterator1<Base:Collection>:IteratorProtocol,Sequence{
    let base:Base
    var offset:Base.Index
    init(_ base:Base) {
        self.base=base
        self.offset=base.startIndex
    }
    
    mutating func next() -> Base.SubSequence? {
        guard offset != base.endIndex else{return nil}
        base.formIndex(after: &offset)
        return base.prefix(upTo: offset)
    }
}












/**
 associatedtype
 
 1、关联类型作为协议实现泛型的一种方式，可以在协议中预先定义一个占位符，实现协议的时候再确定这个占位符具体的类型。
 
 2 . 关联类型需要是一个确定的类型，而不是一个协议
 
 3.如果协议使用了关联类型，那么这个协议就失去了动态派发的特性
 */

protocol A {}
protocol B {
    associatedtype F:A
    func action(_ pA2:F)
}

struct A1:A{}
struct A2:A{}


struct B1<T:A>:B {
    typealias MF = T
    func action(_ pA2: MF) {
        print("我只认对协议[A]实现的[A1,A2]")
    }
}

let action = B1<A1>()
action.action(A1())

let action1 = B1<A2>()
action1.action(A2())




