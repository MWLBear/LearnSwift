//
//  WelcomeView.swift
//  Kuchi
//
//  Created by admin on 2021/1/20.
//  Copyright © 2021 Omnijar. All rights reserved.
//

import SwiftUI

struct WelcomeView: View {
    

    @State var showHome = false
    @EnvironmentObject var userMode: UserManger

    @ViewBuilder
    var body: some View {
        
        if showHome {
           // PracticeView(challgengTest: $chanllengMode.currnetChallenge, userName: $userMode.profile.name)
            HomeView()
        }else{
            
            VStack {
                Text("Hi, \(userMode.profile.name)")
                WelcomeMessageView()

                Button(action: {
                    self.showHome = true
                }, label: {
                    Image(systemName: "play")
                    Text("Start")
                })
            }.background(WelcomeBackgroundImage())
        }
        
       
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environmentObject(UserManger())
    }
}
