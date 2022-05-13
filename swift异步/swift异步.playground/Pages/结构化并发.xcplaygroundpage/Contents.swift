//: [Previous](@previous)

import UIKit
/**
 “async let 被称为异步绑定，它在当前 Task 上下文中创建新的子任务，并将它用作被绑定的异步函数 (也就是 async let 右侧的表达式) 的运行环境。和 Task.init 新建一个任务根节点不同，async let 所创建的子任务是任务树上的叶子节点。被异步绑定的操作会立即开始执行，即使在 await 之前执行就已经完成，其结果依然可以等到 await 语句时再进行求值”


 */

struct NoSignatureError: Error {}


var results:[String] = []

func addAppending(_ value: String, to string: String) {
    results.append(value.appending(string))
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
    
    results = []
    
    let strings = try await loadStrings
    if let signature = try await loadSignature {
        strings.forEach {
            addAppending(signature,to:$0)
        }
    }else {
        throw NoSignatureError()
    }
}

func loadResultRemotely() async throws {
    await Task.sleep(2*NSEC_PER_SEC)
    results = ["data1^sig", "data2^sig", "data3^sig"]
}

func someSyncMethod(){
    Task {
        await withThrowingTaskGroup(of: Void.self, body: { group in
            group.addTask {
                try await loadResultRemotely()
            }
            
            group.addTask(priority: .low) {
                try await processFromScratch()
            }
        })
        print("Done:\(results)")
    }
    
}


someSyncMethod()
