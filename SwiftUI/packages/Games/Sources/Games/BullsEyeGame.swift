
import Foundation
import Combine

public class BullsEyeGame: ObservableObject {

    public let objectWillChange = PassthroughSubject<Void, Never>()

    public var round = 0
    public var startValue = 50
    public var targetValue = 50
    public var scoreRound = 0
    public var scoreTotal = 0
  
    public init() {
    startNewGame()
  }
  
    public func startNewGame() {
    round = 0
    scoreTotal = 0
    startNewRound()
  }
  
    public func startNewRound() {
    round += 1
    scoreRound = 0
    startValue = 50
    targetValue = Int.random(in: 1...100)
    objectWillChange.send()
  }
  
    public func checkGuess(_ guess: Int) {
    let difference = abs(targetValue - guess)
    scoreRound = 100 - difference
    scoreTotal = scoreTotal + scoreRound
    objectWillChange.send()
  }
}
