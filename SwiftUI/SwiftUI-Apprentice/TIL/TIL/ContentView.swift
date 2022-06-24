//
//  ContentView.swift
//  TIL
//
//  Created by admin on 2022/6/23.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject private var myThings: ThingStore

  @State private var showAddThing = false
  var body: some View {
    NavigationView {
      VStack(spacing: 20) {
        if myThings.things.isEmpty {
          Text("Add acronyms you learn")
            .foregroundColor(.gray)
        }
        ForEach(myThings.things) { thing in
          NavigationLink(destination: ThingView(thing: thing)) {
            Text(thing.short)
          }
        }
        Spacer()
      }
      .navigationTitle("TIL")
      .sheet(isPresented: $showAddThing, content: {
        AddThingView()
      })
      .toolbar {
        Button {
          showAddThing.toggle()
        } label: {
          Image(systemName: "plus.circle")
            .font(.title)
        }
      }
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(ThingStore())
  }
}
