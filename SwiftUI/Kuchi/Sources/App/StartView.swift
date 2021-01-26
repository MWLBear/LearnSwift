//
//  StartView.swift
//  Kuchi
//
//  Created by admin on 2021/1/26.
//  Copyright © 2021 Omnijar. All rights reserved.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var userViewModel : UserManger
    var body: some View {
        Group {
            if self.userViewModel.isRegistered {
                WelcomeView()
            }else {
                RegisterView(keyboardHandler: KeyboardFollower())
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .environmentObject(UserManger())
    }
}
