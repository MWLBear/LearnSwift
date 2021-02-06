import UIKit
import Foundation

import Combine
var subscriptions = Set<AnyCancellable>()

/**
 collect()
 The collect operator provides a convenient way to transform a stream of individual values from a publisher into an array of those values.
 
 */

example(of: "collection") {
    
    ["A","B","C","D","E"].publisher.sink(receiveCompletion: { print($0) }, receiveValue: { print($0)} )
        .store(in: &subscriptions)
    
    ["A","B","C","D","E"].publisher.collect(2)
        .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
        .store(in: &subscriptions)
}

example(of: "map") {
    
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    
    [123,4,56].publisher
        .map{ formatter.string(from: NSNumber(integerLiteral: $0)) ?? ""}
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}

example(of: "map key paths") {
    
    let publisher = PassthroughSubject<Coordinate,Never>()
    publisher.map(\.x,\.y)
        .sink { (x,y) in
            print("The coordinate at \(x),\(y) is in quadrant",quadrantOf(x: x, y: y))
        }.store(in: &subscriptions)
    
    publisher.send(Coordinate(x: 10, y: -8))
    publisher.send(Coordinate(x: 0, y: 5))

}

example(of: "try map") {
    Just("Directory name that does not exits")
        .tryMap{
            try FileManager.default.contentsOfDirectory(atPath: $0)
        }.sink(receiveCompletion: {print($0)}, receiveValue: {print($0)})
        .store(in: &subscriptions)
}

example(of: "faltMap") {
    let charlotte = Chatter(name: "Charlotte", message: "Hi, I'm Charlotte")
    let james = Chatter(name: "James", message: "Hi,I'm James")
    let chat = CurrentValueSubject<Chatter,Never>(charlotte)
    chat
        .flatMap(maxPublishers: .max(2)){ $0.message}
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
    
    charlotte.message.value = "Charlotte: How's it going?"
    
    chat.value = james
    
    james.message.value = "James: Doing great. You?"
    charlotte.message.value = "Charlotte: I'm doing fine thanks."
    
    // 8
    let morgan = Chatter(name: "Morgan",
                         message: "Hey guys, what are you up to?")
    // 9
    chat.value = morgan
    // 10
    charlotte.message.value = "Did you hear something?"
}

example(of: "ReplaceNil") {
    ["A",nil,"C"].publisher
        .replaceNil(with: "-")
        .map { $0! }
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
        
}

example(of: "replaceEmpty(with: )") {
    let empty = Empty<Int,Never>()
    empty
        .replaceEmpty(with: 1)
        .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
        .store(in: &subscriptions)

}

example(of: "scan") {
    var dailyGainloss: Int { .random(in: -10...10)}
    let august2019 = (0..<22)
        .map{ _ in dailyGainloss }
        .publisher
    
    august2019.scan(50) { (lastest, current) in
        max(0, lastest + current)
    }
    .sink(receiveValue: { _ in})
    .store(in: &subscriptions)
    
}
