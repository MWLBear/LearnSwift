//
//  FlashDeck.swift
//  Kuchi
//
//  Created by admin on 2021/1/28.
//  Copyright © 2021 Omnijar. All rights reserved.
//

import Foundation
import Combine
final internal class FlashDeck {

    @Published var cards: [FlashCard]
    
    init(form words: [Challenge]) {
        self.cards = words.map {
            FlashCard(card: $0)
        }
    }
}
extension FlashDeck: ObservableObject {
    
}
