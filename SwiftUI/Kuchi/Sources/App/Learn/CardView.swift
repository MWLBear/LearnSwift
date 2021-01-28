//
//  CardView.swift
//  Kuchi
//
//  Created by admin on 2021/1/28.
//  Copyright © 2021 Omnijar. All rights reserved.
//

import SwiftUI

internal enum DiscardedDirection {
    case left
    case right
}


struct CardView: View {
    
    private let flashCard: FlashCard
    @State private var revealed = false
    @State private var offset: CGSize = .zero
    @GestureState var isLongPressed = false
    
    typealias CardDrag = (_ card: FlashCard, _ diection: DiscardedDirection) -> Void
    private let dragged: CardDrag
    
    
    init(_ card: FlashCard, onDrag dragged: @escaping CardDrag = {_,_ in }) {
        self.flashCard = card
        self.dragged = dragged
    }
    
    var body: some View {
        
        let drag = DragGesture()
            .onChanged { self.offset = $0.translation }
            .onEnded {
                if $0.translation.width < -100 {
                    self.offset = .init(width: -1000, height: 0)
                    self.dragged(self.flashCard, .left)
                }else if $0.translation.width > 100 {
                    self.offset = .init(width: 1000, height: 0)
                    self.dragged(self.flashCard, .right)
                }else{
                    self.offset = .zero
                }
            }
        
        let longPress = LongPressGesture()
            .updating($isLongPressed) { (value, state, trsnsiton) in
                state = value
            }.simultaneously(with: drag)
        
        
        
        return ZStack {
            Rectangle()
                .fill(Color.red)
                .frame(width: 320, height: 210)
                .cornerRadius(12)
            VStack {
                Spacer()
                Text(flashCard.card.question)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                if self.revealed {
                    Text(flashCard.card.answer)
                        .font(.caption)
                        .foregroundColor(.white)
                }
                Spacer()
            }
        }.shadow(radius: 8)
        .frame(width: 320, height: 210)
        .animation(.spring())
        .offset(self.offset)
        .gesture(longPress)
        .scaleEffect(isLongPressed ? 1.1 : 1)
        .gesture(TapGesture()
                    .onEnded({
                        withAnimation(.easeIn) {
                            self.revealed = !self.revealed
                        }
                    }))
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(FlashCard(card: Challenge(question: "aaa", pronunciation: "ccc", answer: "ddd")))
    }
}
