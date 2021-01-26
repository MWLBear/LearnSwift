//
//  PracticeView.swift
//  Kuchi
//
//  Created by admin on 2021/1/26.
//  Copyright © 2021 Omnijar. All rights reserved.
//

import SwiftUI

struct PracticeView: View {
    @Binding var challgengTest: ChallengeTest?
    @Binding var userName: String
    
    @ViewBuilder
    var body: some View {
        if challgengTest != nil {
            ChallengeView(challgenTest: challgengTest!)
        }else{
            CongratulationsView(userName: userName)
        }
    }
}

struct PracticeView_Previews: PreviewProvider {
    static let challengeTest = ChallengeTest(
      challenge: Challenge(question: "おねがい　します", pronunciation: "Onegai shimasu", answer: "Please"),
      answers: ["Thank you", "Hello", "Goodbye"]
    )
    
    static var previews: some View {
        PracticeView(challgengTest: .constant(challengeTest), userName: .constant("Johnny Swift"))
    }
}
