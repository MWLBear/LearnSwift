//
//  ContentView.swift
//  RGBullsEye
//
//  Created by admin on 2021/1/13.
//

import SwiftUI
/**
 if the UI should update when its value changes, you designate a variable as a @State variable
 
 In SwiftUI, when a @State variable changes, the view invalidates its appearance and recomputes the body
 
 */
struct ContentView: View {
    let rTarget = Double.random(in: 0..<1)
    let gTarget = Double.random(in: 0..<1)
    let bTarget = Double.random(in: 0..<1)
    @State var rGuess:Double
    @State var gGuess:Double
    @State var bGuess:Double
    @State var showAlert = false
    
    func computeScore() -> Int {
        let rDiff = rGuess - rTarget
        let gDiff = gGuess - gTarget
        let bDiff = bGuess - bTarget
        let diff = sqrt(rDiff*rDiff + gDiff*gDiff + bDiff*bDiff)
        return Int((1-diff) * 100.0 + 0.5)
        
    }
    
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Color(red: rTarget, green: gTarget, blue: bTarget)
                    Text("Mach this color")
                }
                VStack {
                    Color(red: rGuess, green: gGuess, blue: bGuess)
                    Text("R: \(Int(rGuess * 255.0))"
                   + " G: \(Int(gGuess * 255.0))" + " B: \(Int(bGuess * 255.0))")
                }
            }
            Button(action: {self.showAlert = true}) {
                Text("Hit me!")
            }.alert(isPresented: $showAlert, content: {
                Alert(title: Text("Your Score"),message: Text(String(computeScore())))
            }).padding()
            ColorSlider(value: $rGuess, textColor: .red)
            ColorSlider(value: $gGuess, textColor: .green)
            ColorSlider(value: $bGuess, textColor: .blue)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5).previewLayout(.fixed(width: 568, height: 320))
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    var textColor: Color
    
    var body: some View {
        HStack {
            Text("0").foregroundColor(textColor)
            Slider(value: $value)
            Text("255").foregroundColor(textColor)
        }.padding(.horizontal)
    }
}
