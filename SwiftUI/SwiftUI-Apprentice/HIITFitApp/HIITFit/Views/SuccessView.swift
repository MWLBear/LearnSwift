//
//  SuccessView.swift
//  HIITFit
//
//  Created by admin on 2022/6/14.
//

import SwiftUI

struct SuccessView: View {
  @Binding var selectedTab: Int
  @Environment(\.presentationMode) var presentationMode
  var body: some View {
    ZStack {
      VStack(alignment: .center) {
        Image(systemName: "hand.raised.fill")
          .resizedToFill(width: 75, height: 75)
          .foregroundColor(.purple)
        Text(NSLocalizedString("High Five!", comment: "cheer"))
          .font(.largeTitle)
          .fontWeight(.heavy)
        Text("""
          Good job completing all four exercises!
          Remember tomorrow's another day.
          So eat well and get some rest.
          """)
          .multilineTextAlignment(.center)
          .foregroundColor(.gray)
      }
      VStack {
        Spacer()
        Button(NSLocalizedString("Continue", comment: "Continue")) {
          selectedTab = 9
          presentationMode.wrappedValue.dismiss()
        }
        .padding()
      }
    }
  }
}

struct SuccessView_Previews: PreviewProvider {
  static var previews: some View {
    SuccessView(selectedTab: .constant(3))
  }
}
