//
//  ProfileView.swift
//  Kuchi
//
//  Created by admin on 2021/1/28.
//  Copyright © 2021 Omnijar. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var userManager: UserManger
    
    var body: some View {
        
        VStack(spacing: 50) {
            Spacer()
            ZStack(){
                Rectangle()
                    .frame(width:320, height:130)
                    .foregroundColor(Color.orange.opacity(0.5))
                    .cornerRadius(12)
                
                Text(userManager.profile.name)
                    .font(.largeTitle)
            }
            
            ZStack {
                Rectangle()
                    .frame(width:320, height:130)
                    .foregroundColor(Color.red.opacity(0.5))
                    .cornerRadius(12)
                Button(action: {
                    print("好评")
                    UIApplication.shared.openURL(URL(string: "https://www.baidu.com/")!)
                }, label: {
                    Text("goood Me").font(.largeTitle)
                        .foregroundColor(.black)
                })
            }
            
            ZStack {
                Rectangle()
                    .frame(width:320, height:130)
                    .foregroundColor(Color.green.opacity(0.5))
                    .cornerRadius(12)
                Button(action: {
                    if userManager.isRegistered {
                        userManager.clear()
                        exit(0)
                    }
                    
                }, label: {
                    Text("Login Out").font(.largeTitle)
                        .foregroundColor(.black)
                })
            }
            Spacer()
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserManger(name: "123"))
    }
}
