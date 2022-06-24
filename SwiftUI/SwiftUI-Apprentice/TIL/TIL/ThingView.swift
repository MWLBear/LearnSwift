//
//  ThingView.swift
//  TIL
//
//  Created by admin on 2022/6/24.
//

import SwiftUI

struct ThingView: View {
  let thing: Thing
  @State private var showAddThing = false
  var body: some View {
    VStack {
      Text(thing.short)
        .font(.largeTitle)
      Text(thing.long)
        .font(.title)
      Spacer()
    }
    .padding()
    .sheet(isPresented: $showAddThing) {
      AddThingView()
    }
    .toolbar {
      ToolbarItem {
        Button(action: { showAddThing.toggle() }) {
          Image(systemName: "plus.circle")
            .font(.title)
        }
      }
    }
  }
}

struct ThingView_Previews: PreviewProvider {
  static var previews: some View {
    ThingView(thing: Thing(short: "TIL", long: "Thing I Learned"))
  }
}
