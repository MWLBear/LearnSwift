import UIKit

final class Conversion {
    
    // MARK: - 十进制转二进制
    class func decTobin(number:Int) -> String {
        var num = number
        var str = ""
        while num > 0 {
            str = "\(num % 2)" + str
            num /= 2
        }
        return str
    }
    
    // MARK: - 二进制转十进制
    
    class func binTodec(number num: String) -> Int {
        var sum: Int = 0
        for c in num {
            let str = String(c)
            sum = sum * 2 + Int(str)!
        }
        return sum
    }
    
    // MARK: - 十进制转十六进制
    class func decTohex(number:Int) -> String {
        return String(format: "%0X", number)
    }
    
    // MARK: - 十六进制转十进制
    class func hexTodec(number num:String) -> Int {
        let str = num.uppercased()
        var sum = 0
        for i in str.utf8 {
            sum = sum * 16 + Int(i) - 48 // 0-9 从48开始
            if i >= 65 {                 // A-Z 从65开始，但有初始值10，所以应该是减去55
                sum -= 7
            }
        }
        return sum
    }
}
