
import Foundation
import UIKit
import PlaygroundSupport

/**
 可选值 (optional)
 可选值并不是什么魔法，它就 是一个普通的枚举值
 
 
 */

//enum Optional<Wrapped>{
//    case none
//    case some(Wrapped)
//}

extension Collection where Element:Equatable{
    func index(of element:Element) -> Optional<Index> {
        var idx = startIndex
        while idx != endIndex {
            if self[idx] == element{
                return .some(idx)
            }
            formIndex(after: &idx)
        }
        
        return .none
    }
}

var arry = ["one","two","three","four"]

if let idx = arry.index(of: "four"),idx != arry.startIndex {
    arry.remove(at: idx)
}
arry

let urlString = "https://www.objc.io/logo.png"

if let url = URL(string: urlString), url.pathExtension == "png",
    let data = try?Data(contentsOf: url),
    let image = UIImage(data: data)
{
    print(url)
    let view = UIImageView(image: image)
    PlaygroundPage.current.liveView = view

}


let scanner = Scanner(string: "lisa123")
var username:NSString?
let alphas = CharacterSet.alphanumerics
if scanner.scanCharacters(from: alphas, into: &username),let name = username{
    print(name)
}

let arry1 = [1,2,3]
var inerator = arry1.makeIterator()
while let i = inerator.next(){
    print(i,terminator:"")
}
print("\n")

//一个 for 循环其实就是 while 循环
for i in 0..<10 where i % 2 == 0{
    print(i,terminator:"")
}
print("\n")
var inerator2 = (0..<10).makeIterator()
while let i = inerator2.next(){
    if i % 2 == 0 {
        
        print(i)
    }
}


var funstions:[()->Int] = []
for i in 1...3{
    funstions.append {i}
}
for f in funstions{
    print("\(f())",terminator:"")
}


var functions1:[()->Int] = []
var iterator1 = (1...3).makeIterator()
var current1:Int? = iterator1.next()
while current1 != nil{
    let i = current1!
    functions1.append{i}
    current1 = iterator1.next()
}







//双重可选值  一个可选值本身也可以被使用另一个可选值包装起来，这会导致可选值嵌套在可选 值中。这其实不是一个奇怪的边界现象，编译器也不应该自动去将这种情况进行合并处理

let stringNumbers = ["1","2","there"]
let maybeInts = stringNumbers.map{Int($0)}

for maybeint in maybeInts{
    print(maybeint)
}
//使用 case 来进行模式匹配
for case let i? in maybeInts {
    print(i)
}
//这里使用了 x? 这个模式，它只会匹配那些非 nil 的值。这个语法是 .Some(x) 的简写形式
for case let .some(i) in maybeInts{
    print(i)
}

let j = 5
if case 0..<10 = j {
    print("\(j)在范围内内")
}

// case 匹配可以通过重载 ~= 运算符来进行扩展
struct Pattern{
    
    let s:String
    init(_ s:String) {
        self.s = s
    }
    
    static func ~= (pattern:Pattern,value:String) -> Bool {
        print("pattern:\(pattern.s)")

        print("value:\(value)")
        return value.range(of: pattern.s) != nil
    }
}
let s = "Taylor Swift"
if case Pattern("Swift") = s {
print("\(String(reflecting: s)) contains \"Swift\"") }

//func ~=<T, U>(_: T, _: U) -> Bool { return true }

//它重新实现了 URL 和 NSString 的 pathExtension 属性的一部分功能
extension String{
    var fileExtension:String?{
        let period:String.Index
        if let idx = index(of: ".") {
            period = idx
        }else{
            return nil
        }
        let extensionStart = index(after: period)
        return String(self[extensionStart...])
    }
}

"hello.txt".fileExtension

//只在条件成立的情况下继续 guard let
extension String{
    var fileExtesion:String?{
        guard let period = index(of: ".")else{return nil}
        let extensionStart = index(after: period)
        return String(self[extensionStart...])
    }
}

func doStuff(withArry a:[Int]){
    guard !a.isEmpty else{return}
    print(a[0])
}

doStuff(withArry: [1,1,2])


//可选链 当你通过调用可选链得到一个返回值时，这个返回值本身也会是可选值

let str:String? = "Never say never"
let upper:String
if str != nil {
    upper = str!.uppercased()
}else{
    fatalError("no idea what to do now")
}

let result = str?.uppercased().lowercased()

extension Int{
    var half:Int?{
        guard self < -1 || self > 1 else {return nil}
        return self/2
    }
    
}

20.half?.half?.half


struct Person{
    var name:String
    var age:Int
}

var optional:Person? = Person(name: "1", age: 10)

optional?.age += 1


//nil 合并运算符


let characters:[Character] = ["a","b","c"]

//可选值的 map 方法只会操作一个值，那就是该可选值中的那个可能的值。你可以把 可选值当作一个包含零个或者一个值的集合，这样 map 要么在零值的情况下不做处理，要么在 有值的时候会对其进行转换。
let c = characters.first.map{String($0)}

//可选值 􏰁atMap f􏰁atMap 可以把结果展平为单个可选值。
//使用 􏰁atMap 过滤 nil
let numbers = ["1", "2", "3", "foo"]
var sum=0
for case let i? in numbers.map({ Int($0) }) {
    sum+=i }
sum // 6


//可选值判定相等

var dictWithNils: [String: Int?] = [
    "one": 1,
    "two": 2,
    "none": nil
]

dictWithNils["two"] = nil
//dictWithNils["two"]? = nil
//dictWithNils["two"] = .some(nil)
dictWithNils["three"]? = nil
dictWithNils.index(forKey: "three") // nil
print(dictWithNils)

let a: [Int?] = [1, 2, nil]
let b: [Int?] = [1, 2, nil]

a == b
let ages = [
"Tim": 53,"Angela":54,"Craig":44, "Jony": 47, "Chris": 37, "Michael": 34,
]

ages.keys.filter{name in ages[name]!<50}.sorted()

ages.filter { (_,age) in age<50}
    .map{(name,_)in name}.sorted()




//改进强制解包的错误信息
