//
//  ViewController.swift
//  swift并发_01
//
//  Created by admin on 2022/4/20.
//

import UIKit

/**
 
 异步函数
 
 加上async关键词 就可以吧一个函数生命为异步函数
 
 异步函数的 async 关键字会帮助编译器确保两件事情：

 1.它允许我们在函数体内部使用 await 关键字；

 2.它要求其他人在调用这个函数时，使用 await 关键字。


 “async 也扮演了这样一个角色，它要求在特定情况下对当前函数进行标记，这是对于开发者的一种明确的提示，表明这个函数有一些特别的性质：try/throw 代表了函数可以被抛出，而 await 则代表了函数在此处可能会放弃当前线程，它是程序的潜在暂停点。

 放弃线程的能力，意味着异步方法可以被“暂停”，这个线程可以被用来执行其他代码。如果这个线程是主线程的话，那么界面将不会卡顿。被 await 的语句将被底层机制分配到其他合适的线程，在执行完成后，之前的“暂停”将结束，异步方法从刚才的 await 语句后开始，继续向下执行。”


 
 
 “async let 被称为异步绑定，它在当前 Task 上下文中创建新的子任务，并将它用作被绑定的异步函数 (也就是 async let 右侧的表达式) 的运行环境。和 Task.init 新建一个任务根节点不同，async let 所创建的子任务是任务树上的叶子节点。被异步绑定的操作会立即开始执行，即使在 await 之前执行就已经完成，其结果依然可以等到 await 语句时再进行求值”
 
 
 
 
 
 “异步函数：提供语法工具，使用更简洁和高效的方式，表达异步行为。

 结构化并发：提供并发的运行环境，负责正确的函数调度、取消和执行顺序以及任务的生命周期。

 actor 模型：提供封装良好的数据隔离，确保并发代码的安全。”

 
 */

//“actor 模型 (参与者模型)，来解决这些问题。虽然有些偏失，但最简单的理解，可以认为 actor 就是一个“封装了私有队列”的 class”

actor Holder {
    var resluts:[String] = []
    func setResults(_ resluts:[String]){
        self.resluts = resluts
    }
    
    func append(_ value:String){
       self.resluts.append(value)
    }
}

//class Holder {
//
//    //“以前通常的做法是将相关的代码放入一个串行的 dispatch queue 中，然后以同步的方式把对资源的访问派发到队列中去执行，这样我们可以避免多个线程同时对资源进行访问。”
//    private let queue = DispatchQueue(label: "resultholder.queue")
//    private var resluts:[String] = []
//
//    func getReults() -> [String] {
//        queue.sync { resluts }
//    }
//
//    func setResults(_ resluts:[String]){
//        queue.sync { self.resluts = resluts }
//    }
//
//    func append(_ value:String){
//        queue.sync { self.resluts.append(value) }
//    }
//
//}

class ViewController: UIViewController {
    //var results:[String] = []
    
    var holder = Holder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
                for _ in 0 ..< 10000 {
                    someSyncMethod()

                }
//        someSyncMethod()
        
    }
    
    func addAppending(_ value: String, to string: String) async {
      //  results.append(value.appending(string))
        await holder.append(value.appending(string))
    }
    func loadSignature() async throws -> String? {
        await Task.sleep(NSEC_PER_SEC)
        return "^sing"
    }
    
    func loadFormDatabase() async throws -> [String] {
        await Task.sleep(NSEC_PER_SEC)
        return ["data1", "data2", "data3"]
    }
    
    func processFromScratch() async throws {
        async let loadStrings = loadFormDatabase()
        async let loadSignature = loadSignature()
        
        
        let strings = try await loadStrings
        if let signature = try await loadSignature {
            await holder.setResults([])
            for data in strings {
                await holder.append(data.appending(signature))
            }
        }else {
            throw NoSignatureError()
        }
    }
    
    func loadResultRemotely() async throws {
        await Task.sleep(2*NSEC_PER_SEC)
       // results = ["data1^sig", "data2^sig", "data3^sig"]
        await holder.setResults(["data1^sig", "data2^sig", "data3^sig"])
    }
    
    func someSyncMethod(){
        Task {
            await withThrowingTaskGroup(of: Void.self, body: { group in
                group.addTask {
                    try await self.loadResultRemotely()
                }
                
                group.addTask(priority: .low) {
                    try await self.processFromScratch()
                }
            })
            print("Done:\(await holder.resluts)")
        }
    }
    
}

struct NoSignatureError: Error {}
