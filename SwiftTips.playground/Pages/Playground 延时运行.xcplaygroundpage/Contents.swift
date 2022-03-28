//: [Previous](@previous)

import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
class MyClass {
    @objc func  callMe(){
        print("Hi")
    }
}
//
//let object = MyClass()
//Timer.scheduledTimer(timeInterval: 1, target: object, selector: #selector(MyClass.callMe), userInfo: nil, repeats: true)


let url = URL(string: "http://httpbin.org/get")!
let getTask = URLSession.shared.dataTask(with: url) { data, response, error in
    if let httpResponse = response as? HTTPURLResponse ,let date = httpResponse.allHeaderFields["Date"] as? String{
    
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd LLL yyyy HH:mm:ss zzz"
        print(date)
        let date1 = dateFormatter.date(from:date)!
        
        if Date() < date1 {
            print("修改了时间")
        }
    
    }
    let dict = try! JSONSerialization.jsonObject(with: data!, options: [])
    print(dict)
}
getTask.resume()




//: [Next](@next)
