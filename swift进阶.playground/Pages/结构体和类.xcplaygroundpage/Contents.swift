//: [Previous](@previous)

import Foundation
import PlaygroundSupport
import UIKit

var str = "Hello, playground"


/**
 
 → 结构体(和枚举)是值类型，而类是引用类型。在设计结构体时，我们可以要求编译器保 证不可变性。而对于类来说，我们就得自己来确保这件事情。
 → 内存的管理方式有所不同。结构体可以被直接持有及访问，但是类的实例只能通过引用 来间接地访问。结构体不会被引用，但是会被复制。也就是说，结构体的持有者是唯一 的，但是类的实例却能有很多个持有者。
 → 使用类，我们可以通过继承来共享代码。而结构体(以及枚举)是不能被继承的。想要在 不同的结构体或者枚举之间共享代码，我们需要使用不同的技术，比如像是组合、泛型 以及协议扩展等。

 
 
 结构体只有一个持有者。比如，当我们将结构体变量传递给一个函数时，函数将接收到结构体 的复制，它也只能改变它自己的这份复制。这叫做值语义 (value semantics)，有时候也被叫做 复制语义。而对于对象来说，它们是通过传递引用来工作的，因此类对象会拥有很多持有者， 这被叫做引用语义 (reference semantics)。
 
 */
let mutableArray: NSMutableArray = [1,2,3]
for _ in mutableArray {
    mutableArray.removeLastObject()
}
mutableArray

var mutableArray1 = [1, 2, 3]
for _ in mutableArray1 {
    mutableArray1.removeLast()
}
mutableArray1


let mutableArray2: NSMutableArray = [1, 2, 3]
let otherArray = mutableArray2
mutableArray2.add(4)
otherArray // ( 1, 2, 3, 4 )



struct Point{
    var x:Int
    var y:Int
    
}

struct Size{
    var width:Int
    var height:Int
}

struct Rectangle{
    var origin:Point
    var size:Size
}

extension Point{
    static let zero = Point(x: 0, y: 0 )
}

let rect = Rectangle(origin: Point.zero, size: Size(width: 320, height: 480))
print(rect)

extension Rectangle{
    init(x:Int=0,y:Int=0,width:Int,height:Int) {
        origin = Point(x: x, y: y)
        size = Size(width: width, height: height)
    }
}

var screen = Rectangle(width: 320, height: 480){
    didSet{
        print("Screen changed:\(screen)")
    }
}
//screen.origin.x = 10

func + (lhs:Point,rhs:Point)->Point{
    return Point(x: lhs.x+rhs.x, y: lhs.y+rhs.y)
}

extension Rectangle{
    
    mutating func translate(by offset:Point){
        origin = origin+offset
    }
}
screen.translate(by: Point(x: 10, y: 10))
print(screen)

//被 mutating 标记的东西只有在对应实例被 var 声明的时候，才能够被调用:

//let otherScreen = screen
//otherScreen.translate(by: Point(x: 0, y: 0))

extension Rectangle{
    func translated(by offset:Point) -> Rectangle {
        var copy = self
        copy.translate(by: offset)
        return copy
    }
}

//mutating 是如何工作的
/**
 inout 关键词
 
 */


func translatedByTenTen(rectangle:Rectangle)->Rectangle{
    return rectangle.translated(by: Point(x: 10, y: 10))
}

screen = translatedByTenTen(rectangle: screen)
print(screen)

print("---------")
/**
 在全局函数中，我们可以将一个或多个参数标记为 inout 来达到相同的效果。就和一个普通的 参数一样，值被复制并作为参数被传到函数内。不过，我们可以改变这个复制 (就好像它是被 var 定义的一样)。然后当函数返回时，Swift 会将这个 (可能改变过的) 值进行复制并将其返回 给调用者，同时将原来的值覆盖掉。

 */

func translateByTwentyTwenty(rectangle:inout Rectangle){
    rectangle.translate(by: Point(x: 20, y: 20))
}

translateByTwentyTwenty(rectangle: &screen)
print(screen)



func +=(lhs:inout Point,rhs:Point){
    lhs = lhs+rhs
}

var myPoint = Point.zero
myPoint += Point(x: 10, y: 10)
myPoint

/**
 写时复制
 copy-on-write

 在内部，这些 Array 结构体含有指向某个内存的引用。这个内存就是数组中元素所存储的位置。 两个数组的引用指向的是内存中同一个位置，这两个数组共享了它们的存储部分。不过，当我 们改变 x 的时候，这个共享会被检测到，内存将会被复制。这样一来，我们得以独立地改变两个 变量。昂贵的元素复制操作只在必要的时候发生，也就是我们改变这两个变量的时候发生复制:
 
 这种行为就被称为写时复制。它的工作方式是，每当数组被改变，它首先检查它对存储缓冲区 的引用是否是唯一的，或者说，检查数组本身是不是这块缓冲区的唯一拥有者。如果是，那么 缓冲区可以进行原地变更;也不会有复制被进行。不过，如果缓冲区有一个以上的持有者 (如本 例中)，那么数组就需要先进行复制，然后对复制的值进行变化，而保持其他的持有者不受影响。
 
 
 
 */




var input: [UInt8] = [0x61,0x62,0x63,0x64]
var other: [UInt8] = [0x55]

var d = Data(bytes: input)
var e = d
print(input[0])
d.append(contentsOf: other)
String(data: d, encoding: .utf8)
String(data: e, encoding: .utf8)

print(d)
print(e)

//实现写时复制



struct MyData{
    var _data:NSMutableData
    init(_ data:NSData) {
        _data = data.mutableCopy() as! NSMutableData
    }
}





extension MyData{
    func append(_ byte:UInt8) {
        var mutableByte = byte
        _data.append(&mutableByte, length: 1)
        
    }
}



//写时复制-昂贵方式

struct MyData1{
    fileprivate var _data:NSMutableData
    fileprivate var _dataForWriting:NSMutableData{
        
        mutating get{
            _data = _data.mutableCopy() as! NSMutableData
            return _data
        }
    }
    init() {
        _data = NSMutableData()
    }
    init(_ data:NSData) {
        _data = data.mutableCopy() as! NSMutableData
    }
}
extension MyData1{
    mutating func append(_ byte:UInt8){
        var mutableByte = byte
        _dataForWriting.append(&mutableByte, length: 1)
    }
}
let theData = NSData(base64Encoded: "wAEP/w==")!
var x = MyData1(theData)

let y=x
print(y)
x._data === y._data

x.append(0x55)
print(y)

x._data === y._data

//写时复制高效方式
// isKnownUniquelyReferenced 函数来检查某个引 用只有一个持有者。如果你将一个 Swift 类的实例传递给这个函数，并且没有其他变量强引用 这个对象的话，函数将返回 true。

final class Box<A>{
    var unbox:A
    init(_ value:A) {
        self.unbox = value
    }
}

var t = Box(NSMutableData())
isKnownUniquelyReferenced(&t)

struct MyData2{
    private var _data:Box<NSMutableData>
    var _dataForWriting:NSMutableData{
        mutating get{
            if !isKnownUniquelyReferenced(&_data) {
                _data = Box(_data.unbox.mutableCopy() as! NSMutableData)
                print("Making a copy")
            }
            return _data.unbox
        }
        
    }
    
    init() {
        _data = Box(NSMutableData())
    }
    
    init(_ data:NSData) {
        _data = Box(data.mutableCopy() as! NSMutableData)
    }
}

extension MyData2{
    mutating func append(_ byte:UInt8){
        var mutableByte = byte
        _dataForWriting.append(&mutableByte, length: 1)
    }
    
}

var bytes = MyData2()
var cpoy = bytes

for byte in 0..<5 as CountableRange<UInt8>{
    print("Appending 0x\(String(byte,radix: 16))")
    bytes.append(byte)
}
print(bytes)
print(cpoy)


//写时复制的陷阱

final class Empty{}
struct COWStruct {
    var ref = Empty()
    
    mutating func change()->String{
        if isKnownUniquelyReferenced(&ref) {
            return "No copy"
        }else{
            return "Copy"
        }
    }
}

var s = COWStruct()
s.change()

var original = COWStruct()
var copy = original
original.change()

var arry = [COWStruct()]
arry[0].change()

var dict = ["key":COWStruct()]
dict["key"]?.change()


//闭包和可变性

var i = 0
func uniqueInteger()->Int{
    i+=1
    return i
}


func uniqueIntegerProvider()->()->Int{
    var i = 0
    return{
        i += 1
        return i
    }
}

func uniqueIntegerProvider()->AnyIterator<Int>{
    var i = 0
    return AnyIterator{
        i += 1
        return i
    }
    
}

class View{
    var window:Window
    init(window:Window) {
        self.window = window
    }
    
    deinit {
        print("Deinit View")
    }
}

class Window{
   weak var rootView:View?
    var onRotate:(()->())?
    
    deinit {
        print("Deinit Window")
    }
}

var window:Window? = Window()
var view:View? = View(window: window!)

window?.rootView = view

window?.onRotate = {[weak view] in
  print("We now also need to update the view: \(view)")
}
view = nil
window = nil
