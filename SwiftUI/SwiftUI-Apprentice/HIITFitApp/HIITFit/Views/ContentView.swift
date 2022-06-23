//
//  ContentView.swift
//  FirstApp
//
//  Created by admin on 2022/6/13.
//

import SwiftUI

struct ContentView: View {
  // @State property in ContentView means ContentView owns this property, which is the single source of truth for this value.
//  @State private var selectedTab = 9
  @SceneStorage("selectedTab") private var selectedTab = 9
  var body: some View {
    ZStack {
      GradientBackground()
      TabView(selection: $selectedTab) {
        WelcomeView(selectedTab: $selectedTab)
          .tag(9)
        ForEach(0 ..< Exercise.exercises.count) { index in
          ExerciseView(selectedTab: $selectedTab, index: index)
            .tag(index)
        }
      }
      .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
