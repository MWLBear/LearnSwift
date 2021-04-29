//
//  StartView.swift
//  SavannaTours
//
//  Created by admin on 2021/4/28.
//

import SwiftUI

struct StartView: View {
    @State var contentOffset = 0
    var body: some View {
        ZStack {
            Circle()
                .scaleEffect(0.5)
                .foregroundColor(.green)
        }.onAppear{
            
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

let offset: [CGPoint] = [
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
