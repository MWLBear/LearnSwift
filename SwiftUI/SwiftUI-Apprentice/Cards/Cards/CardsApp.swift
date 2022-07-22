//
//  CardsApp.swift
//  Cards
//
//  Created by admin on 2022/6/29.
//

import SwiftUI

@main
struct CardsApp: App {
  @StateObject var viewState = ViewState()
  @StateObject var store = CardStore(defaultData: true)
  var body: some Scene {
    WindowGroup {
      CardsView()
        .environmentObject(viewState)
        .environmentObject(store)
    }
  }
}
