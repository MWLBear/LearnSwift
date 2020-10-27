//: [Previous](@previous)

import Foundation

//重载
/**
 
 泛型编程的目的是表达算法或者数据结构所要求的核心接口
 
 拥有同样名字，但是参数或返回类型不同的多个方法互相称为重载方法，方法的重载并不意味 着泛型。
 
 类型检查器也还是会去选 择那些非泛型的重载，而不去选择泛型重载。
 
 对于重载的运算符，类型检查器会去使 用非泛型版本的重载，而不考虑泛型版本
 
 
 */

//运算符的重载
precedencegroup ExponentiationPrecedence {
    
    associativity: left
    higherThan: MultiplicationPrecedence
}
infix operator **: ExponentiationPrecedence

func **(lhs: Double, rhs: Double) -> Double {
    return pow(lhs, rhs)
}
func **(lhs: Float, rhs: Float) -> Float {
    return powf(lhs, rhs)
}
func **<I: BinaryInteger>(lhs: I, rhs: I) -> I {
// 转换为 Int64，使⽤用 Double 的重载计算结果
    let result = Double(Int64(lhs)) ** Double(Int64(rhs))
    return I(result)
}

let intResult: Int = 2 ** 3 // 8

//使用泛型约束进行重载
extension Sequence where Element:Equatable{
    func isSubset(of other:[Element]) -> Bool {
        for element in self{
            guard other.contains(element)else{
                return false
            }
        }
        return true
    }
}

let oneToThree = [1,2,3]
let fiveToOne = [5,4,3,2,1]
oneToThree.isSubset(of: fiveToOne) // true

extension Sequence where Element:Hashable{
    
    func isSubset(of other:[Element]) -> Bool {
        let otherSet = Set(other)
        for element in self {
            guard otherSet.contains(element) else{
                return false
            }
        }
        return true
    }
}
extension Sequence where Element: Hashable {
    
    /// 如果 `self` 中的所有元素都包含在 `other` 中，则返回 true
    func isSubset<S: Sequence>(of other: S) -> Bool where S.Element == Element
    {
        let otherSet = Set(other)
        for element in self {
            guard otherSet.contains(element)else {
                return false
            }
        }
        return true
    }
}

extension Sequence{
    
    func isSubset<S:Sequence>(of other:S, by areEquivalent:(Element,S.Element)->Bool) -> Bool {
        for element in self {
            guard other.contains(where: {areEquivalent(element,$0)})else{
                return false
            }
        }
        return true
    }
}

let ints = [1,2]
print()
let strings = ["1","2","3"]

let res = ints.isSubset(of: strings) { String($0) == $1 } // true
print(res)

//对集合采用泛型操作

//二分查找
extension Array{
    
    func binarySearch(for value:Element,areInIncreasingOrder:(Element,Element)->Bool) -> Int? {
        var left = 0
        var right = count - 1
        
        while left <= right {
            let mid = (left+right)/2
            let candidate = self[mid]
            
            if areInIncreasingOrder(candidate,value) {
                left = mid+1
            }else if areInIncreasingOrder(value,candidate){
                right = mid-1
            }else{
                return mid
            }
        }
        return nil
        
    }
}

extension Array where Element:Comparable{
    
    func binarySearch(for value:Element) -> Int? {
        return self.binarySearch(for: value, areInIncreasingOrder: <)
    }
}

extension RandomAccessCollection{
    public func binarySearch(for value:Element,areInIncreaingOrder:(Element,Element)->Bool)->Index?{
        guard !isEmpty else{return nil}
        var left = startIndex
        var right = index(before: endIndex)

        while left<=right {
            let dist = distance(from: left, to: right)
            let mid = index(left, offsetBy: dist/2)
            let candidate = self[mid]
            
            if areInIncreaingOrder(candidate,value){
                left = index(after: mid)
            }else if areInIncreaingOrder(value,candidate){
                right = index(before: mid)
            }else{
                return mid
            }
        }
        return nil
    }
}

extension RandomAccessCollection where Element:Comparable{
    func binarySearch(for value:Element) -> Index? {
        return binarySearch(for: value, areInIncreaingOrder: <)
    }
}

let a = ["a", "b", "c", "d", "e", "f", "g"]
let r = a.reversed()
r.binarySearch(for: "g", areInIncreaingOrder: >) == r.startIndex

let s = a[2..<5]
s.startIndex
s.binarySearch(for: "d")


/**
 Fisher Yates 洗牌算法
 
 每次从数组[0,n-1]中随机的选一个数字，然后把这个数字与第一个元素交换。
 接下来从数组[1,n-1]中随机的选一个数字，再把这个数字与第二个元素交换。
 [2,n-2]
 [3,n-3]
 
 这样不断的进行下去，直到最后一个数字。
 这样总体复杂度是O(n)。
 
 */

extension Array{
    
    mutating func shuffle() {
        
        for i in 0..<(count-1) {
            let j = Int(arc4random_uniform(UInt32(count-i))) + i
            self.swapAt(i, j)
        }
    }
    
    public func shuffled() -> [Element] {
        var clone = self
        clone.shuffle()
        return clone
    }
    
}

var shu = [1,2,3,6,7,9,10,2,30,54,11,34,56]
shu.shuffle()

arc4random_uniform(UInt32(4))+1

extension BinaryInteger{
    static func arc4random_uniform(_ upper_bound:Self)->Self{
        precondition(upper_bound>0 && UInt32(upper_bound)<UInt32.max,"arc4random_uniform only callable up to \(UInt32.max)")
        return Self(Darwin.arc4random_uniform(UInt32(upper_bound)))
    }
}

//对泛型洗牌实
extension MutableCollection where Self:RandomAccessCollection{
    
    mutating func shuffle1() {
        
        var i = startIndex
        let beforeEndIndex = index(before: endIndex)
        while i<beforeEndIndex {
            let dist = distance(from: i, to: endIndex)
            let randomDistance = IndexDistance.arc4random_uniform(dist)
            let j = index(i, offsetBy: randomDistance)
            self.swapAt(i,j)
            formIndex(after: &i)
            
        }
    }
}

extension Sequence{
    func shuffled() -> [Element] {
        var clone = Array(self)
        clone.shuffle1()
        return clone
    }
}

var numbers = Array(1...10)
numbers.shuffle1()
numbers // [1, 3, 9, 8, 7, 5, 4, 6, 2, 10]


var webserviceURL:URL!

struct User{
    let name:String
    let age:Int
}


func loadResource<A>(at path:String,parse:(Any)->A?,callback:(A?)->()){
    let resourceURL = webserviceURL.appendingPathComponent(path)
    let data = try?Data(contentsOf: resourceURL)
    let json = data.flatMap {try?JSONSerialization.jsonObject(with: $0, options: [])}
    callback(json.flatMap(parse))
}

func loadUsers(callback:([User]?)->()){
    
    //loadResource(at: "/users", parse: jsonArray(User.init), callback: callback)
}

func jsonArray<A>(_ transform: @escaping (Any) -> A?) -> (Any) -> [A]? {

    return { array in
        guard let array = array as? [Any] else {return nil}
        return array.flatMap(transform)
    }
}

struct Resource<A> {
    let path: String
    let parse: (Any) -> A?
}

extension Resource{
    func loadSynchronously(callback:(A?)->()) {
        let resourceURL = webserviceURL.appendingPathComponent(path)
        let data = try? Data(contentsOf: resourceURL)
        let json = data.flatMap {
        try? JSONSerialization.jsonObject(with: $0, options: []) }
        callback(json.flatMap(parse))
    }
}
//let usersResource: Resource<[User]> = Resource(path: "/users", parse: jsonArray(User.init))

extension Resource {
    
    func loadAsynchronously(callback: @escaping (A?) -> ()) {
        let resourceURL = webserviceURL.appendingPathComponent(path)
        let session = URLSession.shared
        session.dataTask(with: resourceURL) { data, response, error in
            
            let json = data.flatMap {
                try? JSONSerialization.jsonObject(with: $0, options: [])
            }
            callback(json.flatMap(self.parse))
        }.resume()
    }
}



//泛型的工作方式

func min<T: Comparable>(_ x: T, _ y: T) -> T {
    return y<x ? y : x
}

