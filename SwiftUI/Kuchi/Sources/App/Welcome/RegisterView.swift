//
//  RegisterView.swift
//  Kuchi
//
//  Created by admin on 2021/1/29.
//  Copyright © 2021 Omnijar. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    
    @EnvironmentObject var userManager: UserManger
    @ObservedObject var keyboardHandler: KeyboardFollower
    
    init(keyboardHandler: KeyboardFollower) {
        self.keyboardHandler = keyboardHandler
    }
    
    var body: some View {
        VStack (content: {
            WelcomeMessageView()
            TextField("Type your name...",text: $userManager.profile.name).boardered()
            
            HStack {
                Spacer()
                Text("\(userManager.profile.name.count)")
                    .font(.caption)
                    .foregroundColor(
                        userManager.isUserNameValid() ? .green : .red)
                    .padding(.trailing)
            }
            .padding(.bottom)
            
            HStack {
                Spacer()
                Toggle(isOn: $userManager.settings.remenberUser, label: {
                    Text("Remember me")
                        .font(.subheadline)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.gray)
                })
            }
            
            
            
            
            
            Button(action: self.registerUser){
                HStack {
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 16, height: 16, alignment: .center)
                    Text("OK")
                        .font(.body)
                        .bold()
                }
            }
            .boardered()
            .disabled(!userManager.isUserNameValid())
            
        })
        .padding(.bottom,keyboardHandler.keyboardHeight)
        .background(WelcomeBackgroundImage())
        .padding()
        .onAppear { self.keyboardHandler.subscribe() }
        .onDisappear { self.keyboardHandler.unsubscribe() }
    }
}

extension RegisterView {
    func registerUser() {
        
        if userManager.settings.remenberUser {
            userManager.persistProfile()
        }else {
            userManager.clear()
        }
        userManager.persistSettings()
    }
    
}

struct RegisterView_Previews: PreviewProvider {
    static let user = UserManger(name: "Ray")
    
    static var previews: some View {
        RegisterView(keyboardHandler: KeyboardFollower())
            .environmentObject(user)
    }
}
