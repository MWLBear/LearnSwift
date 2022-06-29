//
//  CardsListView.swift
//  Cards
//
//  Created by admin on 2022/6/29.
//

import SwiftUI

struct CardsListView: View {
  @EnvironmentObject var viewState: ViewState
  var body: some View {
    ScrollView(showsIndicators: false) {
      VStack {
        ForEach(0..<10) { _ in
          CardThumbnailView()
            .onTapGesture {
              viewState.showAllCards.toggle()
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
  }
}
