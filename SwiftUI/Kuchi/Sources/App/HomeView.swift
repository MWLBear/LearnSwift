//
//  HomeView.swift
//  Kuchi
//
//  Created by admin on 2021/1/28.
//  Copyright © 2021 Omnijar. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.locale) var locale: Locale
    @State var selectedTab = 0
    
    @EnvironmentObject var userMode: UserManger
    @EnvironmentObject var chanllengMode: ChallengeViewMode
    
    var body: some View {
        
        TabView{
            LearnView()
                .tabItem {
                    VStack {
                        Image(systemName: "bookmark")
                        Text("Learn")
                    }
                }.tag(0)

            
            PracticeView(challgengTest: $chanllengMode.currnetChallenge, userName: $userMode.profile.name)
                .tabItem {
                    VStack {
                        Image(systemName: "rectangle.dock")
                        Text("Challenge")
                    }
                }.tag(1)
            
            
            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                        Text("Profile")
                    }
                }.tag(2)
        }.accentColor(.orange)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(UserManger())
    }
}
