import UIKit
import Combine

var subscriptions = Set<AnyCancellable>()



example(of: "fillter") {
    
    let numbers = (1...10).publisher
    numbers.filter{ $0.isMultiple(of: 3)}
        .sink(receiveValue: { print("\($0) is a multiple of 3")})
        .store(in: &subscriptions)
    
}


example(of: "removeDuplicates") {
    let words = "hey hey there! want to listen to misster misster?".components(separatedBy: " ")
        .publisher
    
    words.removeDuplicates()
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}

example(of: "compactMap") {
    
    let strings = ["a","1.24","3","def","45","0.23"].publisher
    strings.compactMap{ Float($0) }
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
    
}

example(of: "ignoreOutput") {
    let number = (1...10_000).publisher
    number.ignoreOutput()
        .sink(receiveCompletion: { print("Completed with: \($0)") }, receiveValue: { print($0) })
        .store(in: &subscriptions)
}

example(of: "first(where)") {
    let numbers = (1...9).publisher
    numbers.first(where: { $0 % 2 == 0})
        .sink(receiveCompletion: { print("Completed with: \($0)")}, receiveValue: { print($0) })
        .store(in: &subscriptions)
    
}

example(of: "last(where:)") {
    let number = (1...9).publisher
    number.last(where: { $0 % 2  == 0})
        .sink(receiveCompletion: { print("Comleted with: \($0)") }, receiveValue: { print($0) })
        .store(in: &subscriptions)
}

example(of: "laset(whre:)") {
    let numbsers = PassthroughSubject<Int,Never>()
    numbsers.last(where: {$0 % 2 == 0})
        .sink(receiveCompletion: { print("Complted with: \($0)") }, receiveValue: { print($0) })
        .store(in: &subscriptions)
    
    numbsers.send(1)
    numbsers.send(2)
    numbsers.send(3)
    numbsers.send(4)
    numbsers.send(5)
    numbsers.send(completion: .finished)
}

example(of: "dropFirst") {
    let numbers = (1...10).publisher
    
    numbers.dropFirst(8)
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}

example(of: "drop(while)") {
    let numbsers = (1...10).publisher
    numbsers.drop(while: { $0 % 5 != 0})
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
    
}

example(of: "drop(untilOutputFrom:)") {
    let isReady = PassthroughSubject<Void,Never>()
    let taps = PassthroughSubject<Int,Never>()
    
    
    taps.drop(untilOutputFrom: isReady)
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
    
    (1...5).forEach { n in
        taps.send(n)
        
        if n == 3 {
            isReady.send()
        }
    }
}

example(of: "prefix") {
    let numbers = (1...10).publisher
    numbers.prefix(2)
        .sink(receiveCompletion: { print("Complement wiht: \($0)")}, receiveValue: { print($0) })
        .store(in: &subscriptions)
}

example(of: "prefix(while:)") {
    let numbsers = (1...10).publisher
    numbsers.prefix(while: { $0 < 3})
        .sink(receiveCompletion: { print("Completed with: \($0)")}, receiveValue: { print($0) })
        .store(in: &subscriptions)
}

// Once again, as opposed to drop(untilOutputFrom:) which skips values until a second publisher emits, prefix(untilOutputFrom:) takes values until a second publisher emits.

example(of: "prefix(untilOutputFrom:") {
    let isReady = PassthroughSubject<Void,Never>()
    let taps = PassthroughSubject<Int,Never>()
    
    taps.prefix(untilOutputFrom: isReady)
        .sink(receiveCompletion: { print("Complement with: \($0)") }, receiveValue: { print($0) })
        .store(in: &subscriptions)
    
    (1...5).forEach { n in
        taps.send(n)
        if n == 2 {
            isReady.send()
        }
    }
}

example(of: "Challenge") {
    
    let isReady = PassthroughSubject<Void,Never>()
    let taps = PassthroughSubject<Int,Never>()
    
    
    taps.drop(untilOutputFrom: isReady)
        .prefix(while: {$0 < 71 })
        .filter { $0 % 2 == 0}
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
    
    (1...100).forEach { n in
        taps.send(n)
        if n == 51 {
            isReady.send()
        }
    }
    
    print("---------")
    
    let numbsers = (1...100).publisher
    numbsers.dropFirst(50)
        .prefix(20)
        .filter({ $0 % 2 == 0 })
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}
