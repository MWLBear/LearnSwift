//
//  CardsListView.swift
//  Cards
//
//  Created by admin on 2022/6/29.
//

import SwiftUI

struct CardsListView: View {
  @EnvironmentObject var viewState: ViewState
  @EnvironmentObject var store: CardStore
  var body: some View {
    ScrollView(showsIndicators: false) {
      VStack {
        ForEach(store.cards) { card in
          CardThumbnailView(card: card)
            .onTapGesture {
              viewState.selectedCard = card
              viewState.showAllCards.toggle()
            }
            .contextMenu {
              Button {
                store.remove(card)
              } label: {
                Label("Delete",systemImage: "trash")
              }
            }
        }
      }
    }
  }
}

struct CardsListView_Previews: PreviewProvider {
  static var previews: some View {
    CardsListView()
      .environmentObject(ViewState())
      .environmentObject(CardStore(defaultData: true))
  }
}
