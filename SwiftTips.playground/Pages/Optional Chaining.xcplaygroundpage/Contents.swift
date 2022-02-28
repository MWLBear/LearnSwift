//: [Previous](@previous)

class Toy {
    let name: String
    init(name:String){
        self.name = name
    }
}

class Pet {
    var toy: Toy?
}

class Child {
    var pet: Pet?
}

let xiaoming = Child()
if let toyName = xiaoming.pet?.toy?.name {
    print(toyName)
}

extension Toy {
    func play(){
        
    }
}

xiaoming.pet?.toy?.play()

let playClourse = {(child:Child) -> ()? in child.pet?.toy?.play()}

if let _:() = playClourse(xiaoming) {
    print("好开心")
}else {
    print("没有玩具可以玩 :(")
}

//func 的参数修饰


func incremntor(variable: inout Int) {
    variable += 1
}

var luckyNumber = 7
incremntor(variable: &luckyNumber)
print(luckyNumber)
//对于值类型来说 inout 相当于在函数内部创建了一个新的值，
//然后再函数返回的时候将这个值赋值给 &修饰的变量，这与引用类型的行为是不同的

func makeIncrementor(addNumber: Int) -> ((inout Int) -> ()){
    func incrementor(variable: inout Int) ->(){
        variable += addNumber
    }
    return incrementor
}
var number = 10
let abc = makeIncrementor(addNumber: 1)(&number)
print(number)

//字面量
enum MyBool: Int {
    case myTrue,myFalse
}
extension MyBool: ExpressibleByBooleanLiteral {
    init(booleanLiteral value: BooleanLiteralType) {
        self = value ? .myTrue : .myFalse
    }
}

class Person: ExpressibleByStringLiteral{
    let name: String
    init(name value:String){
        self.name = value
    }
    
    required convenience init(stringLiteral value: StringLiteralType) {
        self.init(name: value)
    }
    required convenience init(unicodeScalarLiteral value: String) {
        self.init(name: value)
    }
    required convenience init(extendedGraphemeClusterLiteral value: String) {
        self.init(name: value)
    }
}

let p: Person = "xiaoming"
print(p.name)


//下标





//typealias
class Person1<T>{}
typealias Worker<T> = Person1<T>

protocol Cat {}
protocol Dog {}
typealias Pat = Cat & Dog

//associatedtype


