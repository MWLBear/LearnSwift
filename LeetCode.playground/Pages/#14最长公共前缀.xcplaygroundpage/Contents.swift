//: [Previous](@previous)

import Foundation
class LongestCommonPrefix {
    
    func longestCommonPrefix(_ strs:[String]) -> String {
        guard let firstStr = strs.first else { return "" }
        var res = ""
        for (i,char) in firstStr.enumerated() {
            for str in strs.dropFirst() {
                if i == str.count {
                    return res
                }
                let currentStrChar = str[str.index(str.startIndex, offsetBy: i)]
                print("i:\(i) currentStrChar :\(currentStrChar)")
                if char != currentStrChar {
                    return res
                }
            }
            res.append(char)
        }
        return res
    }
}

let strs = ["flower","flow","flight"]

LongestCommonPrefix().longestCommonPrefix(strs)
