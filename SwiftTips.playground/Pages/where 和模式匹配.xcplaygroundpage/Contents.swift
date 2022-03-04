//: [Previous](@previous)

import Foundation

let name = ["王三","王二","李四","张飞"]
name.forEach({
    switch $0 {
    case let x where x.hasPrefix("王"):
        print("\(x)是姓王的")
    default:
        print("你好，\($0)")
    }
})

let num: [Int?] = [48,49,69,nil]
let n = num.compactMap{ $0 }

for score in n where score > 60 {
    print("及格了:\(score)")
}
print("---------")
num.forEach {
    if let score = $0, score > 60 {
        print("及格了：\(score)")
    }else {
        print(":(")
    }
}


indirect enum LinkedList<Element: Comparable> {
    case empty
    case node(Element,LinkedList<Element>)
    
    
    func removing(_ element: Element) -> LinkedList<Element> {
        guard case let .node(value,next) = self else {
            return .empty
        }
        return value == element ? next : LinkedList.node(value, next.removing(element))
    }
}
let linkedList = LinkedList.node(1, .node(2, .node(3, .node(4, .empty))))
print(linkedList)

let result1 = linkedList.removing(2)
print(result1)

let result2 = linkedList.removing(100)
print(result2)

//: [Next](@next)
