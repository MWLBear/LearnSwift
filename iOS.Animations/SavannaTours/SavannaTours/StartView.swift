//
//  StartView.swift
//  SavannaTours
//
//  Created by admin on 2021/4/28.
//

import SwiftUI

struct StartView: View {
    @State var currentOffset = 0
    @State var color = Color.green
    
    var body: some View {
        ZStack {
            Circle()
                .scaleEffect(0.5)
                .animation(.default)
                .offset(x: offsets[currentOffset].x, y: offsets[currentOffset].y)
                .foregroundColor(colors[currentOffset])
        }.onAppear{
            for index in 1..<offsets.count {
                delay(seconds: Double(index)) {
                    self.currentOffset = index
                }
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

let offsets: [CGPoint] = [
    CGPoint(x: 0, y: 0),
    CGPoint(x: 100, y: 0),
    CGPoint(x: 100, y: -100),
    CGPoint(x: -100, y: -100),
    CGPoint(x: -100, y: 0),
    CGPoint(x: 0, y: 0)
]

let colors: [Color] = [
    Color.green,
    Color.blue,
    Color.red,
    Color.orange,
    Color.yellow,
    Color.green
]
