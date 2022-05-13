import UIKit

var results:[String] = []
func addAppending(_ value: String, to string: String) {
    results.append(value.appending(string))
}

addAppending("123", to: "ui")
results

func loadSignature() throws -> String? {
    let data = try Data(contentsOf: URL(string: "https://www.baidu.com/")!)
    return String(data: data, encoding: .utf8)
}

//异步操作 把实际长时间执行的任务放到另外的线程 (或者叫做后台线程) 运行，然后在操作结束时提供运行在主线程的回调，以供 UI 操作之用：

func loadSignature(_ completion: @escaping(String?,Error?)->Void) {
    
    DispatchQueue.global().async {
        do {
            let d = try  Data(contentsOf: URL(string:"https://www.baidu.com/")!)
            
            DispatchQueue.main.async {
                completion(String(data: d, encoding: .utf8),nil)
            }
            
        }catch {
            DispatchQueue.main.async {
                completion(nil, error)
            }
        }
    }
}

//串行和并行
/*
 同步方法执行同步操作，是串行的成分不必要条件
异步操作，也可能串行方式执行
 
 */

func loadFormDatabase(_ complete: @escaping([String]?,Error?)->Void){
    
}



loadFormDatabase { (strings,error) in
    if let strings = strings {
        loadSignature { signature, error in
            if let signature = signature {
                strings.forEach {
                    addAppending(signature, to: $0)
                }
            }else {
                print("Error")
            }
        }
    }else {
        print("Error")
    }
}





/**
 异步函数
 
 加上async关键词 就可以吧一个函数生命为异步函数
 
 异步函数的 async 关键字会帮助编译器确保两件事情：

 1.它允许我们在函数体内部使用 await 关键字；

 2.它要求其他人在调用这个函数时，使用 await 关键字。


 “async 也扮演了这样一个角色，它要求在特定情况下对当前函数进行标记，这是对于开发者的一种明确的提示，表明这个函数有一些特别的性质：try/throw 代表了函数可以被抛出，而 await 则代表了函数在此处可能会放弃当前线程，它是程序的潜在暂停点。

 放弃线程的能力，意味着异步方法可以被“暂停”，这个线程可以被用来执行其他代码。如果这个线程是主线程的话，那么界面将不会卡顿。被 await 的语句将被底层机制分配到其他合适的线程，在执行完成后，之前的“暂停”将结束，异步方法从刚才的 await 语句后开始，继续向下执行。”


 
 
 */


func loadSignature() async throws -> String? {
    
    let (data, _) = try await URLSession.shared.data(from: URL(string: "https://www.baidu.com/")!)
    
    return String(data: data, encoding: .utf8)
}




