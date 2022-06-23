//
//  FirstAppApp.swift
//  FirstApp
//
//  Created by admin on 2022/6/13.
//

import SwiftUI

@main
struct HIITFitApp: App {
  // You should only use @State properties for temporary items, as they will disappear when the view is deleted. @StateObject will create an observable object which won’t disappear when the view does.

  // @State, being so transient, is incompatible with reference objects and, as HistoryStore is a class, @StateObject is the right choice here.
  @StateObject private var historyStore: HistoryStore
  @State private var showAlert = false
  init() {
    let historyStore: HistoryStore
    do {
      historyStore = try HistoryStore(withChecking: true)
    } catch {
      print("Could not load history data")
      showAlert = true
      historyStore = HistoryStore()
    }
    _historyStore = StateObject(wrappedValue: historyStore)
  }

  var body: some Scene {
    // WindowGroup: Conforms to the Scene protocol. A WindowGroup presents one or more windows that all contain the same view hierarchy.

    // WindowGroup的行为因平台而异。在macOS和iPadOS上，您可以打开多个窗口或场景，但在iOS、tvOS和watchOS上，您只能打开一个窗口。
    WindowGroup {
      ContentView()
        .environmentObject(historyStore)
        .alert(isPresented: $showAlert) {
          Alert(
            title: Text("History·"),
            message: Text(
            """
              Unfortunately we can’t load your past history.
              Email support:
              support@xyz.com
            """))
        }
        .onAppear {
          print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        }
    }
  }
}
