//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
/**
 
 Swift 最大的一个优点是它在于 C 或者 Objective-C 混合使用时，阻力非常小。Swift 可以自动 桥接 Objective-C 的类型，它甚至可以桥接很多 C 的类型。这让我们可以使用现有的代码库， 并且在其基础上提供一个漂亮的 API 接口。
 
 */



func swap<T>(_ arry:inout [T],_ p:Int,_ q:Int){
    assert(p >= 0 && p<arry.count)
    assert(q >= 0 && q<arry.count)

    (arry[p],arry[q]) = (arry[q],arry[p])
}

var ina = [1,3,4,56,90,1]


swap(&ina, 2, 3)

extension String {
  subscript(i: Int) -> Character {
    return self[index(startIndex, offsetBy: i)]
  }
}

//字符串needle在字符串haystack里首次出现的位置

func strStr(haystack: String, _ needle: String) -> Int {
    guard haystack.count != 0 && haystack.count >= needle.count else {
        return -1
    }
    
    for i in 0...haystack.count - needle.count { //5
        guard haystack[i] == needle[0] else {
            continue
        }
        print("i:\(i)")
        for j in 0 ..< needle.count { //3
            guard haystack[i + j] == needle[j] else {
                break
            }
            if j == needle.count - 1 {
                return i
            }
        }
    }
    
    return -1
}

"com".count
strStr(haystack: "applecom123", "com")
