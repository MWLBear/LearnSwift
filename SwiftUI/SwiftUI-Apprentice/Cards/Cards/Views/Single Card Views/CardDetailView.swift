//
//  CardDetail.swift
//  Cards
//
//  Created by admin on 2022/6/29.
//

import SwiftUI

struct CardDetailView: View {
  @EnvironmentObject var viewState: ViewState
  @State private var currentModla: CardModal?
  var body: some View {
    Color.yellow
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            viewState.showAllCards.toggle()
          } label: {
            Text("Done")
          }
        }
        ToolbarItem(placement: .bottomBar) {
          CardBottomToolbar(carModal: $currentModla)
        }
      }
  }
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
      CardDetailView()
        .environmentObject(ViewState())
    }
}
