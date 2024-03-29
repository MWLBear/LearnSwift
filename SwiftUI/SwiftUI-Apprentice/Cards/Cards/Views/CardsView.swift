//
//  CardsView.swift
//  Cards
//
//  Created by admin on 2022/6/29.
//

import SwiftUI

struct CardsView: View {
  @EnvironmentObject var viewState: ViewState
  @EnvironmentObject var store: CardStore
  var body: some View {
    ZStack {
      VStack {
        Button(action: {
          viewState.selectedCard = store.addCard()
          viewState.showAllCards = false
        }, label: {
          Text("Add")
        })
        CardsListView()
      }
      if !viewState.showAllCards {
        SingleCardView()
      }
    }
  }
}

struct CardsView_Previews: PreviewProvider {
  static var previews: some View {
    CardsView()
      .environmentObject(ViewState())
      .environmentObject(CardStore(defaultData: true))
  }
}
