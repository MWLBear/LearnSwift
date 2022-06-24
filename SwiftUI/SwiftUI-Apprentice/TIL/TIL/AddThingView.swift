//
//  AddThingView.swift
//  TIL
//
//  Created by admin on 2022/6/23.
//

import SwiftUI

struct AddThingView: View {
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var someThings: ThingStore

  @State private var short = ""
  @State private var long = ""

    var body: some View {
      VStack {
        TextField("TIL",text: $short)
          .disableAutocorrection(true)
          .autocapitalization(.allCharacters)
        TextField(
          "Thing I Learned",
          text: $long,
          onEditingChanged: { _ in },
          onCommit: { saveAndExit() }
        )
          .autocapitalization(.words)
        Button("Done") { saveAndExit() }
        Spacer()
      }
      .padding()
      .textFieldStyle(RoundedBorderTextFieldStyle())
      .environment(\.textCase, nil)
    }

  private func saveAndExit() {
    if !short.isEmpty {
      someThings.things.append(
        Thing(short: short, long: long)
      )
    }
    presentationMode.wrappedValue.dismiss()
  }
}

struct AddThingView_Previews: PreviewProvider {
    static var previews: some View {
      AddThingView()
        .environmentObject(ThingStore())
    }
}
