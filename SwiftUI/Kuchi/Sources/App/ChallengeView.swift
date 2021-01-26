//
//  ChallengeView.swift
//  Kuchi
//
//  Created by admin on 2021/1/26.
//  Copyright © 2021 Omnijar. All rights reserved.
//

import SwiftUI

struct ChallengeView: View {
    
    let challengeTest: ChallengeTest
    @State var showAnseres = false
    
    init(challgenTest: ChallengeTest) {
        self.challengeTest = challgenTest
    }
    var body: some View {
        
        VStack {
            Button(action: {
                self.showAnseres = !self.showAnseres
            }){
                QuestionView(question: challengeTest.challenge.question)
                    .frame(height: 300)
            }
            
            if showAnseres{
                Divider()
                
                ChoicesView(challengeTest: self.challengeTest)
            }
        }
        
        
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static let challengeTest = ChallengeTest(
        challenge: Challenge(
        question: "おねがい　します􏰀􏰁􏰂􏰃􏰅􏰆􏰇", pronunciation: "Onegai shimasu", answer: "Please"),
        answers: ["Thank you", "Hello", "Goodbye"]
    )
    
    static var previews: some View {
        ChallengeView(challgenTest: challengeTest)
    }
}
