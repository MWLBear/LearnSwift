import Foundation
import Combine

public func example(of description: String,
                    action: () -> Void){
    print("\n ------Example of:",description,"--------")
    action()
}

//public protocol Publisher {
//    // 1
//    associatedtype Output
//    associatedtype Failure : Error
//    // 4
//    func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input
//}
//extension Publisher {
//    // 3
//    public func subscribe<S>(_ subscriber: S) where S : Subscriber,
//                                                    Self.Failure == S.Failure,
//                                                    Self.Output == S.Input
//}
//public protocol Subscriber: CustomCombineIdentifierConvertible {
//    // 1
//    associatedtype Input
//    // 2
//    associatedtype Failure: Error
//    // 3
//    func receive(subscription: Subscription)
//    // 4
//    func receive(_ input: Self.Input) -> Subscribers.Demand
//    // 5
//    func receive(completion: Subscribers.Completion<Self.Failure>)
//}


//The connection between the publisher and the subscriber is the subscription

//public protocol Subscription: Cancellable,
//CustomCombineIdentifierConvertible {
//func request(_ demand: Subscribers.Demand) }
