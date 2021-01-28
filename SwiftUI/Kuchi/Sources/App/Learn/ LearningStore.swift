//
//   LearningStore.swift
//  Kuchi
//
//  Created by admin on 2021/1/28.
//  Copyright © 2021 Omnijar. All rights reserved.
//

import Combine

final class LearningStore {
    
    @Published var deck: FlashDeck
    @Published var card: FlashCard
    @Published var score = 0
    
    init() {
        let deck = FlashDeck(form: ChallengeViewMode().challenges)
        self.deck = deck
        self.card = FlashCard(card: Challenge(question: "", pronunciation: "", answer: ""))
        
        if let nextCard = getNextCard() {
            self.card = nextCard
        }
    }
    
    func getNextCard() -> FlashCard? {
        if let nextCard = self.getLaseCard() {
            self.card = nextCard
            self.deck.cards.removeLast()
        }
        return self.card
    }
    
    func getLaseCard() -> FlashCard? {
        if let lastCard = deck.cards.last {
            self.card = lastCard
            return self.card
        }else {
            return nil
        }
    }
}
extension LearningStore: ObservableObject {
}
