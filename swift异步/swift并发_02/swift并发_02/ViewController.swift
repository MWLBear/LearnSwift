//
//  ViewController.swift
//  swift并发_02
//
//  Created by admin on 2022/4/20.
//

import UIKit
import Combine


class ViewController: UIViewController  {
    
    override func viewDidLoad()    {
        super.viewDidLoad()
        
        Task {
            do {
                //同步
                //syncFib()
                
               // try await classAsyncFib()
                //try await transformFib()
                
//                try await debugFib()
//
//                let f = FibonacciSequence().lazy.map{ $0 }
//                print(f)
//
//                timer()
                
//              try await timer2()
                
//                await backPressure()
                
//                try await timerByPublisher()
                
//                try await checkImageFormat()
                 
//                try await sessionLines()
               
//                try await notications()
                
                await syncMethod()
            }catch {
                print("Error:\(error)")
            }
        }
        
    }
    
    
    func syncFib(){
        for c in FibonacciSequence() {
            if c < 200 {
                print("fib:\(c)")
            }else{
                break
            }
        }
    }
    
    func structAsyncFib() async throws{
        let asyncFib = AsyncFibonacciSequence()
        for try await v in asyncFib {
            if v < 20 {
                print("async fib:\(v)")
            }else {
                break
            }
        }
        
        for try await v in asyncFib {
            print("next value:\(v)")
        }
    }
    
    func classAsyncFib() async throws {
        let asyncFib = ClassFibonacciSequence()
        for try await v in asyncFib {
            if v < 20 {
                print("async fib:\(v)")
            }else {
                break
            }
        }
        
        for try await v in asyncFib {
            print("next value:\(v)")
        }
    }
    
    //操作异步序列
    func transformFib() async throws{
        let seq = AsyncFibonacciSequence()
            .filter { $0.isMultiple(of: 2)}
            .prefix(5)
            .map{ $0 * 2 }
        
        for try await v in seq {
            print(v)
        }
    }
    
    func debugFib() async throws {
        let seq = AsyncFibonacciSequence()
            .prefix(5)
            .print()
            .filter { $0.isMultiple(of: 2)}
            .map{ $0 * 2 }
        
        for try await v in seq {
            print("Value:\(v)")
        }
    }
    
    
    var transformedFibonacciSequene: some AsyncSequence {
        AsyncFibonacciSequence()
            .filter{ $0.isMultiple(of: 2)}
            .prefix(5)
            .map{ $0 * 2}
    }
    
    func timer(){
        let initial = Date()
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            let now = Date()
            print("Value:\(now)")
            let diff = now.timeIntervalSince(initial)
            if diff > 10 {
                timer.invalidate()
            }
        }
    }
    
    func timerByWrapping() async{
        
        Task {
            let timer =  timerStream
            await Task.sleep(5 * NSEC_PER_SEC)
            
            for await v in timer {
                print(v)
            }
            print("Done")
        }
    }
    
    
    func timer2 () async throws{
//        let t = Task {
//            let timer =  timerStream
//            for await v in timer {
//                print(v)
//            }
//        }
//        await Task.sleep(2 * NSEC_PER_SEC)
//        t.cancel()

        
        //“bufferingOldest 或者 bufferingNewest 的绑定值可能被设为 0。这种情况意味着 AsyncStream 中不存在可用的缓冲区，continuation 的 yield 方法所产生的值将被直接抛弃掉。这个特性可以让我们拥有在运行时通过设置缓冲区策略来暂时“关闭”异步序列的能力。”
        
        Task {
            let timer =  timerStream(bufferingPolicy: .bufferingNewest(0))
            await Task.sleep(5 * NSEC_PER_SEC)
            
            for await v in timer {
                print(v)
            }
            print("Done")
        }
        
    }
    
    func backPressure() async {
        Task {
            let timer = AsyncStream<Date>{
                await  Task.sleep(NSEC_PER_SEC)
                return Date()
            }onCancel: { @Sendable in
                print("Canceled.")
            }
            
            for await v in timer {
                print(v)
            }
            print("Done")
        }
    }
    
    func timerByPublisher() async throws {
    
        let stream = Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .asAsyncStream
        
        for try await v in stream {
            print(v)
        }
    }
    
    
    var timerStream: AsyncStream<Date> {
        timerStream(bufferingPolicy: .unbounded)
    }
  
    func timerStream(bufferingPolicy policy: AsyncStream<Date>.Continuation.BufferingPolicy) -> AsyncStream<Date> {
        
        AsyncStream(bufferingPolicy: policy) { continuation in
            let initial = Date()
            
            Task {
                let t = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    let now = Date()
                    let reslut = continuation.yield(Date())
                    print("Call yield:\(reslut)")

                    let diff = now.timeIntervalSince(initial)
                    if diff > 10 {
                        print("Call finish")
                        continuation.finish()
                    }
                }
                
                continuation.onTermination = {
                    @Sendable state in
                    print("on Termination: \(state)")
                    t.invalidate()
                }
            }
            
        }
        
    }
    
}

//同步迭代器
struct FibonacciSequence: Sequence {
    struct Iterator: IteratorProtocol {
        var state = (0, 1)
        mutating func next() -> Int? {
            let upcomingNumber = state.0
            state = (state.1, state.0 + state.1)
            return upcomingNumber
        }
    }
    func makeIterator() -> Iterator {
        .init()
    }
}

//异步迭代器 异步迭代器的值语义
struct AsyncFibonacciSequence:AsyncSequence {
    typealias Element = Int
    struct AsyncIterator:AsyncIteratorProtocol {
        var currentIndex = 0
        mutating func next() async throws -> Int? {
            defer { currentIndex += 1}
            return try await loadFibNumber(at:currentIndex)
        }
    }
    func makeAsyncIterator() -> AsyncIterator {
        .init()
    }
}

//“引用语义迭代器”
class ClassFibonacciSequence: AsyncSequence {
    typealias Element = Int

    private var iterator: AsyncIterator?

    class AsyncIterator:AsyncIteratorProtocol {
        var currentIndex = 0
        func next() async throws -> Int? {
            defer { currentIndex += 1}
            return try await loadFibNumber(at:currentIndex)
        }
    }
    
    func makeAsyncIterator() -> AsyncIterator {
        if iterator == nil {
            iterator = .init()
        }
        return iterator!
    }
    
}
//单次遍历
class Box<T> {
    var value: T
    init(_ value:T) { self.value = value}
}
struct BoxedFibonacciSequence:AsyncSequence,AsyncIteratorProtocol {
    typealias Element = Int
    var currnetIndex = Box(0)
    
    mutating func next() async throws -> Int? {
        defer { currnetIndex.value += 1}
        return try await loadFibNumber(at: currnetIndex.value)
    }
    
    func makeAsyncIterator() -> Self {
        self
    }
}


//

struct AsyncSlideEffectSequene<Base:AsyncSequence> : AsyncSequence {
    
    struct AsyncIterator: AsyncIteratorProtocol {
        private var base: Base.AsyncIterator
        private let blcok: (Element) async -> ()
        
        init(_ base: Base.AsyncIterator, block: @escaping (Element) async -> ()) {
            self.base = base
            self.blcok = block
        }
        
        mutating func next() async throws -> Base.Element? {
            let value = try await base.next()
            if let value = value {
                await blcok(value)
            }
            
            return value
        }
    }
    
    typealias Element = Base.Element
    private let base: Base
    private let block: (Element) async -> ()
    
    init(_ base:Base, block: @escaping (Element) -> ()) {
        self.base = base
        self.block = block
    }
    
    func makeAsyncIterator() -> AsyncIterator {
        return AsyncIterator(base.makeAsyncIterator(), block: block)
    }
}


func loadFibNumber(at index: Int) async throws -> Int {
    await Task.sleep(NSEC_PER_SEC)
    return fibNumber(at: index)
}

func fibNumber(at index: Int) -> Int {
    if index == 0 { return 0 }
    if index == 1 { return 1 }
    return fibNumber(at: index - 2) + fibNumber(at: index - 1)
}

extension AsyncSequence {
    func print() -> AsyncSlideEffectSequene<Self> {
        AsyncSlideEffectSequene(self) {
            Swift.print("go to new value: \($0)")
        }
    }
}

//把任意的 Publisher 用异步序列表示

extension Publisher {
    var asAsyncStream: AsyncThrowingStream<Output, Error> {
        AsyncThrowingStream(Output.self) { continuation in
            let cancleable = sink { complete in
                switch complete {
                case .finished:
                    continuation.finish()
                case .failure(let error):
                    continuation.finish(throwing: error)
                }
            } receiveValue: { output in
                continuation.yield(output)
            }
            
            continuation.onTermination = {
                @Sendable _ in
                cancleable.cancel()
            }
        }
    }
}


// 系统API

extension ViewController {
    
    func checkImageFormat() async throws{
        let url = URL(string: "https://objccn.io/images/books/async-swift/cover.png")!
        let session = URLSession.shared
        let (bytes,_) = try await session.bytes(from: url)
        var pngHeader: [UInt8] = [137, 80, 78, 71, 13, 10, 26, 10]

        for try await byte  in bytes.prefix(8) {
            if byte != pngHeader.removeFirst() {
                print("Not PNG")
                return
            }
        }
        print("PNG")
    }
    
    func sessionLines() async throws {
        let url = URL(string: "https://www.baidu.com/")!
        let session = URLSession.shared
        let (bytes, _) = try await session.bytes(from: url)
        for try await line in bytes.lines {
            print(line)
        }
    }
    
    func notications() async {
        let backgroundNotificaions = NotificationCenter.default.notifications(named: UIApplication.didEnterBackgroundNotification, object: nil)
//        for await notification in backgroundNotificaions {
//            print(notification)
//            break
//        }
        
        if let notification = await backgroundNotificaions.first(where: { _ in  true }) {
            print(notification)
        }
    }
    
    func asyncMethod() async -> Bool {
        await Task.sleep(NSEC_PER_SEC)
        return true
    }
    
    func syncMethod() async {
        let task = Task {
            await asyncMethod()
        }
        let result = await task.value
        print(result)
    }
}
