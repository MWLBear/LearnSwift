//
//  CardToolbar.swift
//  Cards
//
//  Created by admin on 2022/7/13.
//

import SwiftUI

struct CardToolbar: ViewModifier {
  @EnvironmentObject var viewState: ViewState
  @Binding var currentModal: CardModal?
  func body(content: Content) -> some View {
    content.toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          viewState.showAllCards.toggle()
        } label: {
          Text("Done")
        }
      }
      ToolbarItem(placement: .bottomBar) {
        CardBottomToolbar(carModal: $currentModal)
      }
    }
  }
}
