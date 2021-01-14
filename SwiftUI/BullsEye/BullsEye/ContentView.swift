//
//  ContentView.swift
//  BullsEye
//
//  Created by admin on 2021/1/14.
//

import SwiftUI

struct ContentView: View {
    @State  var speed = 50.0
    @State var showAlert = false
    let target = Int.random(in: 1...100)
    
    func computeScore() -> Int {
        let diff = abs(Int(speed) - target)
        let points = 100 - diff
        return points
    }
    var body: some View {
        VStack {
            Text("Put the Bull's Eye as close as you can to: \(target)")
            HStack {
                Text("0")
                Slider(value: $speed,in: 0.0...100.0,step:1)
                Text("100")
            }.padding(.horizontal)
            Button(action: {self.showAlert = true}) {
                Text("Hit me")
            }.alert(isPresented: $showAlert, content: {
                Alert(title: Text("Your Score"),message: Text(String(computeScore())))
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 568, height: 320))
    }
}
