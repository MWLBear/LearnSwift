//: [Previous](@previous)

import Foundation


let data = 1...3
let result = data.map { i -> Int in
    print("正在处理\(i)")
    return i * 2
}
print("准备访问结果")
for i in result {
    print("操作后结果为 \(i)")
}
print("操作完毕")






//Reflection 和 Mirror

struct Person {
    let name: String
    let age: Int
}
let xiaoming = Person(name: "xiaoming", age: 18)
let r = Mirror(reflecting: xiaoming)
print(r.displayStyle)
print(r.children.count)

for child in r.children {
    print("属性名:\(child.label) 值：\(child.value)")
}

dump(xiaoming)


func valueForm(_  object: Any,key: String) -> Any? {
    let mirror = Mirror(reflecting: object)
    for child in mirror.children {
        let (targetKey,targeMirror) = (child.label,child.value)
        if key == targetKey {
            return targeMirror
        }
    }
    return nil
}

if let name = valueForm(xiaoming, key: "name") as? String {
    print("通过key得到值:\(name)")
}

//多重 Optional
var aNil: String? = nil

var anotherNil: String?? = aNil
var literNil: String? = nil

if anotherNil != nil {
    print("anotherNil")
}
if literNil != nil {
    print("literNil")
}
//: [Next](@next)
