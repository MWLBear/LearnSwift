//
//  ViewController.swift
//  swift并发_04
//
//  Created by admin on 2022/5/11.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        Task {
//            await CancleReturnHandling().start()
            
//            await TaskTreeCancel().start()
            
            await URLSessionCancel().start()
        }
    }
    
}

struct SingCancle {
    
    func start() async {
        let t = Task {
            let value = await work()
            print(value)
        }
        
        await Task.sleep(UInt64(2.5 * Double(NSEC_PER_SEC)))
        t.cancel()
    }
    
    func work() async  -> String {
        var s = ""
        for c in "Hello" {
            
            await Task.sleep(NSEC_PER_SEC)
            print("Append:\(c) cancelled:\(Task.isCancelled)")
            s.append(c)
        }
        return s
    }
    
}

struct CancleReturnHandling {
    func start() async {
        let t = Task {
            let value = await work()
            print(value)
        }
        
        await Task.sleep(UInt64(2.5 * Double(NSEC_PER_SEC)))
        t.cancel()
    }
    
    func work() async  -> String {
        var s = ""
        for c in "Hello" {
            
            guard !Task.isCancelled else {
                return s
            }
            await Task.sleep(NSEC_PER_SEC)
            print("Append:\(c)")
            s.append(c)
        }
        return s
    }
}

struct CancelThrowHandling {
    
    func start() async {
        let t = Task {
            
            do {
                let value = try await work()
                print(value)
            } catch is CancellationError {
                print("任务取消")
            }catch {
                print("其它错误")
            }
           
        }
        
        await Task.sleep(UInt64(2.5 * Double(NSEC_PER_SEC)))
        t.cancel()
    }
    
    func work() async throws -> String {
        var s = ""
        for c in "Hello" {
            
            try Task.checkCancellation()
            await Task.sleep(NSEC_PER_SEC)
            print("Append:\(c)")
            s.append(c)
        }
        return s
    }
}


struct TaskTreeCancel {
    
    func start() async{
        let autoCancel = true
        let t = Task {
            do {
                let value: String = try await withThrowingTaskGroup(of: String.self) { group in
                    
                    group.addTask {
                        try await withThrowingTaskGroup(of: String.self) { inner in
                            inner.addTask {
                                try await work("Hello",autoCancel:autoCancel)
                            }
                            
                            inner.addTask {
                                try await work("World!",autoCancel:autoCancel)
                            }
                            await Task.sleep(UInt64(2.5 * Double(NSEC_PER_SEC)))
                            inner.cancelAll()
                            
                            return try await inner.reduce([], {
                                $0 + [$1]
                            }).joined(separator: " ")
                        }
                    }
                    group.addTask {
                        try await work("Swift Concurrency",autoCancel:autoCancel)
                    }
                    return try await group.reduce([]) { $0 + [$1] }.joined(separator: " ")
                }
                print(value)
                
            }catch {
                print(error)
            }
        }
        
//        await Task.sleep(NSEC_PER_SEC)
//        t.cancel()
        
    }
    
    func work(_ text:String,autoCancel:Bool) async throws -> String {
        var s = ""
        for c in text {
            if Task.isCancelled {
                print("Cancelled:\(text)")
            }
            if !autoCancel {
                try Task.checkCancellation()
                await Task.sleep(NSEC_PER_SEC)
            }else {
                try await Task.sleep(nanoseconds: NSEC_PER_SEC)
            }
            
            print("Append:\(c)")
            s.append(c)
            
        }
        print("Done:\(s)")
        
        return s
    }
}
struct URLSessionCancel {
    func start() async {
        let t = Task {
            do {
                let (data, _) = try await
                    URLSession.shared.data(from: URL(string: "https://example.com")!, delegate: nil)
                print(data.count)
            } catch {
                print(error)
            }
        }
        await Task.sleep(100)
        t.cancel()
    }
}
