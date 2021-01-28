//
//  FlashCard.swift
//  Kuchi
//
//  Created by admin on 2021/1/28.
//  Copyright © 2021 Omnijar. All rights reserved.
//

import Foundation
struct FlashCard {
    
    var card: Challenge
    var id = UUID()
    var isActive = true
    
}

extension FlashCard: Identifiable{
    
}

extension FlashCard: Equatable{
    
    static func == (lhs: FlashCard, rhs: FlashCard) -> Bool {
        return lhs.card.question == rhs.card.question &&
            lhs.card.answer == rhs.card.answer
    }
}

