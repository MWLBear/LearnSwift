import UIKit
import Combine
var subscriptions = Set<AnyCancellable>()

example(of: "Publisher") {
    let myNotication = Notification.Name("MyNotification")
    
    let publisher = NotificationCenter.default.publisher(for: myNotication, object: nil)
    
    
    let center = NotificationCenter.default
    let observer = center.addObserver(forName: myNotication, object: nil, queue: nil) { notification in
        print("notification reveived!")
    }
    center.post(name: myNotication, object: nil)
    center.removeObserver(observer)
}

//The sink operator will continue to receive as many values as the publisher emits

//When a subscriber is done and no longer wants to receive values from a publisher, it’s a good idea to cancel the subscription to free up resources and stop any corresponding activities from occurring, such as network calls.


example(of: "Subscriber") {
    let myNotification = Notification.Name("MyNotification")
    let publisher = NotificationCenter.default.publisher(for: myNotification, object: nil)
    let center = NotificationCenter.default
    
    let subscription = publisher.sink { _ in
        print("Notification received from a publisher!")
    }

    center.post(name: myNotification, object: nil)
    subscription.cancel()

}
// a Just happily emits its output to each new subscriber exactly once and then finishes.

example(of: "Just") {
    let just = Just("Hello world!")
    _ = just.sink(
        receiveCompletion: {
            print("Received completion", $0)
    }, receiveValue: {
        print("Received value",$0)
    })
    _ = just.sink(receiveCompletion: {
        print("Received completion (another)", $0)
    }, receiveValue: {
        print("Received value (another)", $0)
    })
}

example(of: "assign(to:on:)") {
    class SomeObject {
        var value: String = "" {
            didSet {
                print(value)
            }
        }
    }
    let object = SomeObject()
    let publisher = ["Hello","world"].publisher
    _ = publisher.assign(to: \.value, on: object)
    
}


/**
 1. The subscriber subscribes to the publisher.
 2. The publisher creates a subscription and gives it to the subscriber.
 3. The subscriber requests values.
 4. The publisher sends values.
 5. The publisher sends a completion.

 1.订阅者订阅发布者。
 2.发布者创建一个订阅并将其提供给订阅者。
 3.订阅者请求值。
 4.发布者发送值。
 5.发布者发送完成。
 
 */

example(of: "Custom Subsciber") {
    let publisher = (1...6).publisher
    
    final class IntSubscriber: Subscriber {
        typealias Input = Int
        typealias Failure = Never
        
        func receive(subscription: Subscription) {
            subscription.request(.max(1))
        }
        
        func receive(_ input: Int) -> Subscribers.Demand {
            print("Received value",input)
            return .unlimited
        }
        
        func receive(completion: Subscribers.Completion<Never>) {
            print("Received completioin",completion)
        }
    }
    
    let subscriber = IntSubscriber()
    
    publisher.subscribe(subscriber)
    
}

// a Future can be used to asynchronously produce a single result and then complete.
//example(of: "Future") {
//    func futureIncrement(
//        integer: Int,
//        afterDelay dely: TimeInterval) -> Future<Int, Never>{
//
//        Future<Int,Never>{ promise in
//            print("Original")
//            DispatchQueue.global().asyncAfter(deadline: .now() + dely) {
//                promise(.success(integer + 1))
//            }
//        }
//    }
//    let future = futureIncrement(integer: 1, afterDelay: 3)
//    future.sink {
//        print($0)
//    } receiveValue: {
//        print($0)
//    }.store(in: &subscriptions)
//
//    future.sink {
//        print("Second",$0)
//    } receiveValue: {
//        print("Second",$0)
//    }.store(in: &subscriptions)
//}

example(of: "PassthroughSubject") {
    enum MyError: Error {
        case test
    }
    
    final class StringSubscriber: Subscriber{
        typealias Input = String
        typealias Failure = MyError
        
        func receive(subscription: Subscription) {
            subscription.request(.max(2))
        }
        func receive(_ input: String) -> Subscribers.Demand {
            print("Received value", input)
            return input == "World" ? .max(1) : .none
        }
        func receive(completion: Subscribers.Completion<MyError>) {
            print("Reveived complment",completion)
        }
    }
    let subscriber = StringSubscriber()
    
    let subject = PassthroughSubject<String, MyError>()
    subject.subscribe(subscriber)
    
    
    let subscription = subject.sink { //Creates another subscription using sink.
        print("Received completion (sink)", $0)
    } receiveValue: {
        print("Received value (sink)", $0)
    }

    subject.send("Hello")
    subject.send("World")

    subscription.cancel()
    subject.send("Still there?")
    
    subject.send(completion: .failure(MyError.test))
    subject.send(completion: .finished)
    subject.send("How about another one?")
}


example(of: "CurrentaValueSubject") {
    var subscriptions = Set<AnyCancellable>()
    let subject = CurrentValueSubject<Int, Never>(0)
    subject.print()
        .sink { print($0)}
        .store(in: &subscriptions)
        
    subject.send(1)
    subject.send(2)
    print(subject.value)
    subject.value = 3
    print(subject.value)
    
    subject.print()
        .sink(receiveValue: { print("Second subscription:",$0) })
        .store(in: &subscriptions)
    
    subject.send(completion: .finished)
}

example(of: "Dynamically adjusting") {
    final class IntSubscriber: Subscriber {
        typealias Input = Int
        typealias Failure = Never
        
        func receive(subscription: Subscription) {
            subscription.request(.max(2))
        }
        func receive(_ input: Int) -> Subscribers.Demand {
            print("Received value",input)
            switch input {
            case 1:
                return .max(2)
            case 3:
                return .max(1)
            default:
                return .none
            }
        }
        func receive(completion: Subscribers.Completion<Never>) {
            print("Received completion",completion)
        }
    }
    
    let subscriber = IntSubscriber()
    let subject = PassthroughSubject<Int, Never>()
    
    subject.subscribe(subscriber)
    
    subject.send(1)
    subject.send(2)
    subject.send(3)
    subject.send(4)
    subject.send(5)
    subject.send(6)

}

example(of: "Type erasure") {
    let subject = PassthroughSubject<Int, Never>()
    
    let publisher = subject.eraseToAnyPublisher()
    
    publisher.sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
    
    subject.send(0)
    
}
