//
//  TILApp.swift
//  TIL
//
//  Created by admin on 2022/6/23.
//

import SwiftUI

@main
struct TILApp: App {
  @StateObject private var store = ThingStore()
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(store)

        }
    }
}
