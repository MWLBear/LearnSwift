//
//  SingleCardView.swift
//  Cards
//
//  Created by admin on 2022/6/29.
//

import SwiftUI

struct SingleCardView: View {
  @EnvironmentObject var store: CardStore
  @EnvironmentObject var viewState: ViewState
  var body: some View {
    if let selectedCard = viewState.selectedCard,
       let index = store.index(for: selectedCard)
    {
      NavigationView {
        CardDetailView(card: $store.cards[index])
          .navigationBarTitleDisplayMode(.inline)
      }.navigationViewStyle(StackNavigationViewStyle())
    }
  }
}

struct SingleCardView_Previews: PreviewProvider {
  static var previews: some View {
    SingleCardView()
      .environmentObject(ViewState(card: initialCards[0]))
      .environmentObject(CardStore(defaultData: true))
  }
}

