//
//  DeckView.swift
//  Kuchi
//
//  Created by admin on 2021/1/28.
//  Copyright © 2021 Omnijar. All rights reserved.
//

import SwiftUI

struct DeckView: View {
    
    @ObservedObject private var deck: FlashDeck
    private let onMemorized: () -> Void
    
    init(onMemrized: @escaping ()->Void, deck: FlashDeck) {
        self.onMemorized = onMemrized
        self.deck = deck
    }
    private func getCardView(for card: FlashCard) -> CardView {
        let activeCards = deck.cards.filter{ $0.isActive == true }
        if let lastCard = activeCards.last {
            if lastCard == card {
                return createCardView(for: lastCard)
            }
        }
        let view = createCardView(for: card)
        return view
    }
    
    func createCardView(for card: FlashCard) -> CardView {
        let view = CardView(card) { (card, direction) in
            if direction == .left {
                self.onMemorized()
            }
        }
        return view
    }
    var body: some View {
        ZStack {
            ForEach(deck.cards.filter{ $0.isActive == true}){ flashcard in
                self.getCardView(for: flashcard)
            }
        }
    }
    
}

struct DeckView_Previews: PreviewProvider {
    static var previews: some View {
        DeckView(onMemrized: {}, deck: LearningStore().deck)
    }
}
