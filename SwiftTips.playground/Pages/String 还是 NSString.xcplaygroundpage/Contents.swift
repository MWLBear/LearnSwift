//: [Previous](@previous)

import Foundation

let levels = "ABCDE"
if levels.contains("A"){
    print("yes")
}
let nsRange = NSMakeRange(1, 4)
(levels as NSString).replacingCharacters(in: nsRange, with: "AAAA")
//: [Next](@next)
