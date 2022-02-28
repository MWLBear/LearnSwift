//: [Previous](@previous)

import UIKit
import Foundation

struct RegexHelper {
    let regex: NSRegularExpression
    init(_ pattern: String) throws {
        try regex = NSRegularExpression(pattern:pattern,
                                        options:.caseInsensitive)
    }
    func math(_ input: String) ->Bool {
        let maths = regex.matches(in: input, options: [], range: NSMakeRange(0, input.utf16.count))
        return maths.count > 0
    }
}
let mailPattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
let matcher: RegexHelper
do {
    matcher = try RegexHelper(mailPattern)
}
let mayMailAdress = "lz@qq.com"
if matcher.math(mayMailAdress){
    print("有效的邮箱地址")
}



precedencegroup MatchPrecedence {
    associativity: none
    higherThan: DefaultPrecedence
}
infix operator =~: MatchPrecedence

func =~(lhs: String,rhs: String) -> Bool {
    do {
        return try RegexHelper(rhs).math(lhs)
    }catch _ {
        return false
    }
}

if "lz@qq.com" =~ "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$" {
    print("有效的邮箱地址1")
}

let test = "HelO"
let interval = "a"..."z"
for c in test {
    if !interval.contains(String(c)){
        print("\(c)不是小写字母")
    }
}

//: [Next](@next)
