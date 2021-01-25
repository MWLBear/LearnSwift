//
//  WelcomeMessageView.swift
//  Kuchi
//
//  Created by admin on 2021/1/29.
//  Copyright © 2021 Omnijar. All rights reserved.
//

import SwiftUI

struct WelcomeMessageView: View {
    var body: some View {
        
        HStack{
            LogoImage()
            
            VStack {
                Text("Welcome to")
                    .font(.headline)
                    .bold()
                    
                Text("KuChi")
                    .font(.largeTitle)
                    .bold()
            }
            .foregroundColor(.red)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
            .padding(.horizontal)
        }
       
    }
}

struct WelcomeMessageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeMessageView()
    }
}
