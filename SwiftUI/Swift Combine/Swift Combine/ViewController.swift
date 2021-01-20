//
//  ViewController.swift
//  Swift Combine
//
//  Created by admin on 2021/1/20.
//


import UIKit
import Combine

class Student {
    let name: String
    var score: Int

    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
}




class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let student = Student(name: "Jack", score: 90)
        print(student.score)
        let observer = Subscribers.Assign(object: student, keyPath: \Student.score)
        let publisher = PassthroughSubject<Int, Never>()
        
        publisher.subscribe(observer)
        publisher.send(91)
        print(student.score)
        publisher.send(100)
        print(student.score)
    }

    
    func publisher() {
        
    

    }
    
    func subscriber() {
        
        class RXContentController {
            //CurrentValueSubject 的功能很简单，就是包含一个初始值，并且会在每次值变化的时候发送一个消息，这个值会被保存，可以很方便的用来替代 Property Observer
            var content = CurrentValueSubject<[String], NSError>([])
            func getContent() {
                content.value = ["hello","world"]
            }
        }
        
        
        class StudentManager {
            
            
            var namePublisher: AnyPublisher<String, Never>!
          
            
            func updateStudentsFromLocal() {
                
                let student1 = Student(name: "Jack", score: 75)
                let student2 = Student(name: "David", score: 80)
                let student3 = Student(name: "Alice", score: 96)
                
               
                
                let namesPublisher: AnyPublisher<String,Never> = Publishers.Sequence<[Student], Never>(sequence: [student1, student2, student3]).map { $0.name }.eraseToAnyPublisher()
                self.namePublisher = namesPublisher
                
            }
            
            

        }
    }

}

/**
 Publisher
 在 Combine 中，Publisher 是观察者模式中的 Observable，并且可以通过组合变换（利用 Operator）重新生成新的 Publisher。
 
 
 
 
 Subscriber
 和 Publisher 相对应的，Subscriber 就是观察者模式中 Observer。
 
 
 publisher 在自身状态改变时，调用 Subscriber 的三个不同方法（receive(subscription), receive(_:Input), receive(completion:)）来通知 Subscriber。
 
 Combine 内置的 Subscriber 有三种：

 Sink
 Assign
 Subject
 
 Sink 是非常通用的 Subscriber，我们可以自由的处理数据流的状态。
 
 PassthroughSubject 这里是 Combine 内置的一个 Publisher
 PassthroughSubject 和 CurrentValueSubject 几乎一样，只是没有初始值，也不会保存任何值。
 
 
 
 操作符
 操作符是 Combine 中非常重要的一部分，通过各式各样的操作符，可以将原来各自不相关的逻辑变成一致的（unified）、声明式的（declarative）的数据流。

 转换操作符：

 map/mapError
 flatMap
 replaceNil
 scan
 setFailureType
 过滤操作符：

 filter
 compactMap
 removeDuplicates
 replaceEmpty/replaceError
 reduce 操作符：

 collect
 ignoreOutput
 reduce
 运算操作符：

 count
 min/max
 匹配操作符：

 contains
 allSatisfy
 序列操作符：

 drop/dropFirst
 append/prepend
 prefix/first/last/output
 组合操作符：

 combineLatest
 merge
 zip
 错误处理操作符：

 assertNoFailure
 catch
 retry
 时间控制操作符：

 measureTimeInterval
 debounce
 delay
 throttle
 timeout
 其他操作符：

 encode/decode
 switchToLatest
 share
 breakpoint/breakpointOnError
 handleEvents
 
 */

