//: [Previous](@previous)



let a =  RomanToInteger().romanToInt(s: "VII")
print(a)

class RomanToInteger {
    func romanToInt(s:String) -> Int {
        let dict = initDict()
        let chars = [Character](s.reversed())
        print("chars:\(chars)")
        var res = 0
        
        for i in 0..<chars.count {
            guard let current = dict[String(chars[i])] else { return res }
            print("i:\(i) current:\(current)")
            if i > 0 && current < dict[String(chars[i - 1])] ?? 0{
                res -= current
            }else {
                res += current
            }
        }
        return res
    }
    
    private func initDict()->[String:Int]{
        var dict = [String: Int]()
        
        dict["I"] = 1
        dict["V"] = 5
        dict["X"] = 10
        dict["L"] = 50
        dict["C"] = 100
        dict["D"] = 500
        dict["M"] = 1000
        
        return dict
    }
}

[1,2,3].dropFirst()
