//
//  WelcomeView.swift
//  Kuchi
//
//  Created by admin on 2021/1/20.
//  Copyright © 2021 Omnijar. All rights reserved.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        
        ZStack {
            WelcomeBackgroundImage()
            WelcomeMessageView()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
