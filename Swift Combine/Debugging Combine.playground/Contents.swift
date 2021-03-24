import UIKit
import Combine
var scriptions = [AnyCancellable]()


class TimeLogger: TextOutputStream {
    private var previous = Date()
    private let formatter = NumberFormatter()
    
    init() {
        formatter.maximumFractionDigits = 5
        formatter.minimumFractionDigits = 5
    }
    
    func write(_ string: String) {
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        let now = Date()
        print("+\(formatter.string(for:now.timeIntervalSince(previous))!)s: \(string)")
        
        previous = now
        
    }
}

let subscription = (1...3).publisher
    .print("publisher",to: TimeLogger())
    .sink{ _ in }

let request = URLSession.shared
    .dataTaskPublisher(for: URL(string: "https://www.baidu.com/")!)

request
    .handleEvents(receiveSubscription: { _ in
        print("Network request will start")
    }, receiveOutput: { _ in
        print("Network request data received")
    }, receiveCancel: {
        print("Network request cancelled")
    })
    .sink(receiveCompletion: { completion in
        print("Sink received completion: \(completion)")
      }) { (data, _) in
        print("Sink received data: \(data)")
      }
    .store(in: &scriptions)

let runloop = RunLoop.main
let subscription1 = runloop.schedule(after: runloop.now, interval: .seconds(1),tolerance: .milliseconds(100)){
   // print("Time fired")
}
runloop.schedule(after: .init(Date(timeIntervalSinceNow: 3.0))) {
    subscription1.cancel()
}


let publisher = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    .scan(0) { counter, _ in
        counter + 1
    }.sink { count in
       // print("Counter is \(count)")
    }

let queue = DispatchQueue.main
let source = PassthroughSubject<Int,Never>()
var counter = 0
let cancellable = queue.schedule(after: queue.now, interval: .seconds(1)) {
    source.send(counter)
    counter += 1
}

//let subscription2 = source.sink {
//   print("Timer emitted \($0)")
//}


//KVO-compliant


class TestObject: NSObject {
    @objc dynamic var integerProperty: Int = 0
}

let obj = TestObject()
//•.initial发出初始值。
//•.prior发生更改时会同时发出前一个值和新值。
//•.old和.new在此发布者中未使用，它们都不执行任何操作（只是让新值通过）。
let subscription3 = obj.publisher(for: \.integerProperty,options: [.prior])
    .sink {
        print("IntegerProperty changes to \($0)")
    }

obj.integerProperty = 100
obj.integerProperty = 200

//ObservableObject


class MotionObject:ObservableObject {
    @Published var someProperty = false
    @Published var someOtherProperty = ""
}

let object1 = MotionObject()
let subscription4 = object1.objectWillChange.sink {
    print("object will change")
}
object1.someProperty = true
object1.someOtherProperty = "Hello World"






let shared = URLSession.shared .dataTaskPublisher(for: URL(string: "https://www.raywenderlich.com")!)
    .map(\.data)
    .print("shared")
    .share()
print("subscribing frist")
let subscription5 = shared.sink(receiveCompletion: {_ in}, receiveValue:{ print("subscription5 received: '\($0)'")})
print("subscribing second")
let subscription6 = shared.sink(receiveCompletion: {_ in}, receiveValue:{ print("subscription6 received: '\($0)'")})

print("-----------")



//let future = Future<Int,Error>{ fulfill in
//    do {
//        let result = try performSomeWork()
//        fulfill(.success(result))
//        
//    }catch{
//        fulfill(.failure(error))
//    }
//}



//关键点
//•在处理诸如网络之类的资源密集型流程时，共享订阅工作至关重要。
//•当您只需要与多个订阅者共享一个发布者时，请使用share（）。
//•当需要更好地控制上游发布者的时间时，请使用 multicast(_:)
//开始起作用，以及值如何传播到订户。
//•使用Future将计算的单个结果共享给多个订户。
