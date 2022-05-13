//
//  ViewController.swift
//  swift并发_03
//
//  Created by admin on 2022/4/29.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
//            await TaskGroupSample().start()
//            await TaskGroupEscapingSample().start()
//            await AsyncLetSample().start()
//            await AsyncLetWithoutAwaitSample().start()
//            await TaskGroupCombination().start()
//            await TaskGroupDeferSample().start()
//            await AsyncLetCombination().start()
            
        //    await TopLevelTask().start()
            
            
            await test()
        }
        
    }
    
    
    func task() {
        withUnsafeCurrentTask { task in
            //1
            print(task as Any)
        }
        
        Task {
            //2
            await foo()
        }
        
        Task {
            let t1 = Task {
                print("t1:\(Task.isCancelled)")
            }
            let t2 = Task {
                print("t2:\(Task.isCancelled)")

            }
            t1.cancel()
            
            print("t:\(Task.isCancelled)")
            
        }
    }
    
    
    func foo() async {
        withUnsafeCurrentTask { task in
            //3
            if let task = task {
                //4
                print("Cancelled:\(task.isCancelled)")
                print(task.priority)
                
            }else {
                print("no task")
            }
        }
    }
    
    
    func test() async {
        
        for i  in 0...10 {
            let  result = await work(i)
            print("i:\(i) ,result = \(result)")
        }
        
    }
    
}


func work(_ value:Int) async -> Int {
    //print("Start work:\(value)")
    await Task.sleep(UInt64(value) * NSEC_PER_SEC)
   // print("Work \(value) Done")
    return value
}


//任务组
struct TaskGroupSample {
    func start() async {
        print("start")
        let v:Int =  await withTaskGroup(of: Int.self) { group in
            var value = 0
            for i in 0..<3 {
                group.addTask {
                    return await work(i)
                }
            }
            print("Task added")
            
            for await result in group {
                value += result
                print("get result:\(result)")
            }
            return value
            print("task ended")
        }
        print("end。reslut:\(v)")
        
    }
    
}


struct TaskGroupEscapingSample {
    func start() async {
        print("Start")
        var g: TaskGroup<Int>? = nil
        await withTaskGroup(of: Int.self) { group in
            g = group
            for i in 0 ..< 3 {
                group.addTask {
                    await work(i)
                }
            }
            print("Task added")
            for await result in group {
                print("Get result: \(result)")
                break
            }
            print("Task ended")
        }
        g?.addTask {
            await work(1)
        }
        print("End")
    }
}

struct AsyncLetSample {
    
    func start() async {
        print("Start")
        async let v0 = work(0)
        async let v1 = work(1)
        async let v2 = work(2)
        print("Task added")
        
        let result = await v0 + v1 + v2
        
        print("Task ended")
        print("End. Result: \(result)")
    }
}

struct AsyncLetWithoutAwaitSample {
    func start() async {
        print("Start")
        async let v0 = work(0)
        async let v1 = work(1)
        async let v2 = work(2)
        print("Task added")
        
        print("Task ended")
        print("End.")
    }
}

//结构化并发的组合
struct TaskGroupCombination {
    
    func start()async {
        await withTaskGroup(of: Int.self) { group in
            group.addTask {
                await withTaskGroup(of: Int.self) { innerGroup in
                    
                    innerGroup.addTask {
                        await work(0)
                    }
                    innerGroup.addTask {
                        await work(2)
                    }
                    return await innerGroup.reduce(0, { reult,value  in
                        reult + value
                    })
                }
            }
            group.addTask {
                await work(1)
            }
        }
        print("End")
    }
    
}

struct TaskGroupDeferSample {
    
    func start() async {
        print("Start")
        await withTaskGroup(of: Int.self) { group in
            defer {
                print("Defer..")
            }
            for i in 0 ..< 3 {
                group.addTask {
                    await work(i)
                }
            }
            print("Task added")
            print("Task ended")
            await group.waitForAll()
        }
        
        print("End")
    }
}


struct AsyncLetCombination{
    
    func start() async {
        //“async let 赋值等号右边，接受的是一个对异步函数的调用。这个异步函数可以是像 work 这样的具体具名的函数，也可以是一个匿名函数。”
        
        async let v02 : Int =  {
            async let r1 = work(0)
            async let r2 = work(2)
            return await r1 + r2
        }()
        
        async let v1 = work(1)
        
        _ = await v02 + v1
        
        print("End")
    }
}

struct TopLevelTask {
    func start() async {
        let t1 = Task {
            await work(2)
        }
        let t2 = Task.detached {
            await work(1)
        }
        let v1 = await t1.value
        let v2 = await t2.value
        
        print("reslut:\(v1 + v2)")
        
    }
}

