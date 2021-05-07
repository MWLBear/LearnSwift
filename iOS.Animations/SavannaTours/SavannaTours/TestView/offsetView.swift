//
//  offsetView.swift
//  SavannaTours
//
//  Created by admin on 2021/4/29.
//

import SwiftUI

struct offsetView: View {
    var body: some View {
        
//        VStack {
//            Text("Home")
//            Text("Options")
//                .offset(y:15)
//                .padding(.bottom,15)
//            Text("Help")
//        }
        
//        HStack {
//            Text("Before")
//                .background(Color.red)
//                .offset(y:15)
//            Text("After")
//                .offset(y:15)
//                .background(Color.red)
//        }
        
//        ZStack(alignment: .bottomTrailing) {
//            Image("thumb")
//            Text("Photo credit: Paul Hudson.")
//                .padding(4)
//                .background(Color.black)
//                .foregroundColor(.white)
//                .offset(x: -5, y: -5)
//        }
        
        Text("Offset by passing horizontal & vertical distance")
            .border(Color.green)
            .offset(x: 30, y: 50)
            .border(Color.gray)
    }
}

struct offsetView_Previews: PreviewProvider {
    static var previews: some View {
        offsetView()
    }
}
