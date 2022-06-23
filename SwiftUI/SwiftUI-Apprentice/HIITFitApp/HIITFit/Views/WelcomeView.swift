//
//  WelcomeView.swift
//  HIITFit
//
//  Created by admin on 2022/6/13.
//

import SwiftUI

struct WelcomeView: View {
  @State private var showHistory = false
  @Binding var selectedTab: Int
  var getStartButton: some View {
    RaiseButton(buttonText: "Get Start") {
      selectedTab = 0
    }
    .padding()
  }
  var historyButton: some View {
    Button {
      showHistory = true
    } label: {
      Text("History")
        .fontWeight(.bold)
        .padding([.leading, .trailing], 5)
    }
    .padding(.bottom, 10)
    .buttonStyle(EmbossedButtonStyle())
  }
  var body: some View {
    GeometryReader { geometry in
      VStack {
        HeaderView(selectedTab: $selectedTab, titleText: NSLocalizedString("Welcome", comment: "greeting"))
        Spacer()
        ContainerView {
          VStack {
            WelcomeView.images
            WelcomeView.welcomeText
            getStartButton
            Spacer()
            historyButton
          }
        }
        .frame(height: geometry.size.height * 0.8)
      }
      .sheet(isPresented: $showHistory) {
        HistoryView(showHistory: $showHistory)
      }
    }
  }
}
struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView(selectedTab: .constant(9))
  }
}
