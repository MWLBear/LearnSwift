//
//  ContentView.swift
//  SavannaTours
//
//  Created by admin on 2021/4/28.
//

import SwiftUI

struct ContentView: View {
    @State var zoomed = false
    
    var body: some View {
        
        VStack(spacing: 0) {
            HeroImage(name: "hero")
            ZStack {
                HStack {
                    TourTitle(title: "Savanna Trek", caption: "15 mile drive followed by an hour long trek")
                        .offset(x: 0, y: -15)
                        .padding(.leading,30)
                        .offset(x: self.zoomed ? 500: 0, y: -15)
                        .animation(.default)
                    Spacer()
                }
                GeometryReader() { geometry in
                Image("thumb")
                    .clipShape(RoundedRectangle(cornerRadius: self.zoomed ? 40: 500))
                    .overlay(
                        Circle().fill(self.zoomed ? Color.clear: Color(red: 1.0, green: 1.0, blue: 1.0,opacity: 0.4))
                            .scaleEffect(0.8)
                    )
                    .saturation(self.zoomed ? 1 : 0)
                    .rotationEffect(self.zoomed ? .degrees(0): .degrees(90))
                    .position(x: self.zoomed ? geometry.frame(in: .local).midX: 600, y: 50)
                    .scaleEffect(self.zoomed ? 1.33 : 0.33)
                    .shadow(radius: 10)
                    .animation(.spring())
                    .onTapGesture {
                        self.zoomed.toggle()
                    }
                }
            }.background(Color(red: 0.1, green: 0.1, blue: 0.1))
            
            MiletonesList()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
