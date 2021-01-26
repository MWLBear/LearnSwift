//
//  ChallengesViewModel.swift
//  Kuchi
//
//  Created by admin on 2021/1/26.
//  Copyright © 2021 Omnijar. All rights reserved.
//
import SwiftUI
import Combine


struct Challenge {
    let question: String
    let pronunciation: String
    let answer: String
    let completed: Bool = false
    let succeeded: Bool = false
}

extension Challenge: Hashable {
    func hash(into hasher: inout Hasher) {
        question.hash(into: &hasher)
    }
}

struct ChallengeTest {
    let challenge: Challenge
    let answers: [String]
    func isAnswerCorrent(_ answer: String) -> Bool {
        return challenge.answer == answer
    }
}

class ChallengeViewMode: ObservableObject {
    
    let challenges: [Challenge] = [
        Challenge(question: "はい", pronunciation: "Hai", answer: "Yes"),
        Challenge(question: "いいえ", pronunciation: "iie", answer: "No"),
        Challenge(question: "おねがい　します", pronunciation: "Onegai shimasu", answer: "Please"),
        Challenge(question: "こんにちわ", pronunciation: "Konnichiwa", answer: "Hello"),
        Challenge(question: "はじめまして", pronunciation: "Hajimemashite", answer: "Nice to meet you"),
        Challenge(question: "もしもし", pronunciation: "Moshi moshi", answer: "Hello"),
        Challenge(question: "すみません", pronunciation: "Sumimasen", answer: "Excuse me"),
        Challenge(question: "ありがとう", pronunciation: "Arigatō", answer: "Thank you"),
        Challenge(question: "ごめんなさい", pronunciation: "Gomennasai", answer: "Sorry")
      ]
    
    var allanswers: [String] { return challenges.map{ $0.answer } }
    var correntAnswers: [Challenge] = []
    var wrongAnswers: [Challenge] = []
    @Published var currnetChallenge: ChallengeTest?
    
    init() {
        generateRandomChallenge()
    }
    
    
    func getRandomAnswers(count: Int, including incluedAnser: String) -> [String] {
        let anseres = allanswers
        
        guard count < allanswers.count else {
            return allanswers.shuffled()
        }
        
        var randomAnseres = Set<String>()
        randomAnseres.insert(incluedAnser)
        while randomAnseres.count < count {
            guard let randomAnswer = anseres.randomElement() else {
                continue
            }
            randomAnseres.insert(randomAnswer)
        }
        
        return Array(randomAnseres).shuffled()
    }
    
    func restart() {
        self.correntAnswers = []
        self.wrongAnswers = []
        generateRandomChallenge()
    }
    
    func generateRandomChallenge() {
        if correntAnswers.count < 5 {
            currnetChallenge = getRandomChallenge()
        }else{
            currnetChallenge = nil
        }
    }
    
    
    private func getRandomChallenge() -> ChallengeTest? {
        return getRandomChallenge(count: 1).first
    }
    
    
    private func getRandomChallenge(count: Int) -> [ChallengeTest]{
        let challenges = self.challenges.filter{$0.completed == false}
        var randomChallenges: Set<Challenge>
        
        if challenges.count < count {
            randomChallenges = Set(challenges)
        }else{
            randomChallenges = Set()
            while randomChallenges.count < count {
                guard let randomChallenge = challenges.randomElement() else {
                    continue
                }
                randomChallenges.insert(randomChallenge)
            }
        }
        
        let tests = randomChallenges.map({
            ChallengeTest(challenge: $0, answers:  getRandomAnswers(count: 3, including: $0.answer))
        })
        
        return tests.shuffled()
    }
    
    
    func saveCorrectAsnser(for changlle: Challenge) {
        correntAnswers.append(changlle)
    }
    
    func saveWrongAsnser(for changlle: Challenge) {
        wrongAnswers.append(changlle)
    }
    
    
}
