//
//  ThingStore.swift
//  TIL
//
//  Created by admin on 2022/6/24.
//

import SwiftUI

final class ThingStore: ObservableObject{
  @Published var things: [Thing] = []
}

struct Thing: Identifiable {
  let id = UUID()
  let short: String
  let long: String
}
