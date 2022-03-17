//: [Previous](@previous)

import UIKit

// 创建目标队列
let workingQueue = DispatchQueue(label: "my_queue")
// 派发刚创建的队列，gcd会负责进行线程调度
//workingQueue.async {
//    // 异步执行
//    print("努力工作")
//    Thread.sleep(forTimeInterval: 2) // 模拟两秒的执行时间
//    // 回到主线程
//    DispatchQueue.main.async {
//        print("结束工作，更新UI")
//    }
//}

// 取消



//: [Next](@next)
