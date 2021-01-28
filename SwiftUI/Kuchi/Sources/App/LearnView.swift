//
//  LearnView.swift
//  Kuchi
//
//  Created by admin on 2021/1/28.
//  Copyright © 2021 Omnijar. All rights reserved.
//

import SwiftUI

struct LearnView: View {
    @ObservedObject private var learningStore = LearningStore()
    
    var body: some View {
        VStack{
            Spacer()
            Text("Swipe left if you remembered"
                    + "\nSwipe right if you didn’t")
                .font(.headline)
            DeckView(onMemrized: {
                self.learningStore.score += 1
            }, deck: self.learningStore.deck)
            Spacer()
            Text("Remembered \(self.learningStore.score)" + "/\(self.learningStore.deck.cards.count)")
        }
        
    }
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
    }
}
