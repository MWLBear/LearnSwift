//
//  ChallengesApp.swift
//  Challenges
//
//  Created by admin on 2021/3/24.
//

import SwiftUI

@main
struct ChallengesApp: App {
  
    var store = AppStore(initiaState: .init(), reducer: appReducer, environment: Environment())

    var body: some Scene {
        WindowGroup {
            ContainerView()
                .environmentObject(store)
        }
    }
}
