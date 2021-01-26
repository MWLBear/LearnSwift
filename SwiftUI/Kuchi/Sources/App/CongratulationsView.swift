//
//  CongratulationsView.swift
//  Kuchi
//
//  Created by admin on 2021/1/26.
//  Copyright © 2021 Omnijar. All rights reserved.
//

import SwiftUI

struct CongratulationsView: View {
    
    @EnvironmentObject var challgenViewMode: ChallengeViewMode
    let avatarSize: CGFloat = 120
    let userNmae: String
    
    init(userName: String) {
        self.userNmae = userName
    }
    
    
    var body: some View {
        
        VStack {
            Spacer()
            Text("Congratulations!")
                .font(.title)
                .foregroundColor(.gray)
            
            ZStack {
                VStack(spacing:0) {
                    Rectangle()
                        .frame(height: 90)
                        .foregroundColor(Color(red: 0.5, green: 0, blue: 1).opacity(0.2))
                    Rectangle()
                        .frame(height:90)
                        .foregroundColor(Color(red: 0.6, green: 0.1, blue:  0.1).opacity(0.4))
                }
                Image(systemName: "person.fill")
                    .resizable()
                    .padding()
                    .frame(width: avatarSize, height: avatarSize)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(avatarSize/2,antialiased: true)
                    .shadow(radius: 4)
                
                VStack {
                    Spacer()
                    Text(userNmae)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .shadow(radius: 7 )
                }.padding()
            }.frame(height: 180)
            
            Text("You're awesome!")
                .fontWeight(.bold)
                .foregroundColor(.gray)
            
            Spacer()
            
            Button(action: {
                self.challgenViewMode.restart()
            }, label: {
                Text("Play Agaiin")
            }).padding(.bottom)
        }
        
       
    }
}

struct CongratulationsView_Previews: PreviewProvider {
    static var previews: some View {
        CongratulationsView(userName: "lz")
            .environmentObject(ChallengeViewMode())
    }
}
