//
//  ChoicesView.swift
//  Kuchi
//
//  Created by admin on 2021/1/26.
//  Copyright © 2021 Omnijar. All rights reserved.
//

import SwiftUI

struct ChoicesView: View {
    let challengeTest: ChallengeTest
    @State var challgengeSolved = false
    @State var isChallengeReslutAlertDisplayed = false
    @EnvironmentObject var challengeViedMode: ChallengeViewMode
    
    var body: some View {
    
        VStack(spacing: 25){
            
            ForEach(0..<challengeTest.answers.count){ index in
                Button(action: {
                    self.challgengeSolved = self.checkAnswer(at: index)
                    self.isChallengeReslutAlertDisplayed = true
                }, label: {
                    ChoicesRow(choice: self.challengeTest.answers[index])
                }).alert(isPresented: self.$isChallengeReslutAlertDisplayed, content: {
                    
                    self.challengeOutcomeAlert()
                })
                
                Divider()
            }
        }
        
    }
    
    func challengeOutcomeAlert() -> Alert {
        let alert: Alert
        
        if challgengeSolved {
            
            let dismissButton = Alert.Button.default(Text("OK")){
                
                self.isChallengeReslutAlertDisplayed = false
                self.challengeViedMode.generateRandomChallenge()
            }
            alert = Alert(title: Text("Congratulations"), message: Text("The answer is correct"), dismissButton: dismissButton)
            
        }else{
            let dismissButton = Alert.Button.default(Text("OK")){
                self.isChallengeReslutAlertDisplayed = false
            }
            alert = Alert(title: Text("Oh no!"), message: Text("Your answer is not corrent"), dismissButton: dismissButton)
        }
        
        return alert
    }
    
    
    func checkAnswer(at index: Int) -> Bool {
        let answer = self.challengeTest.answers[index]
        let challengeSolved:Bool
        
        if challengeTest.isAnswerCorrent(answer) {
            challengeSolved = true
            challengeViedMode.saveCorrectAsnser(for: challengeTest.challenge)
        }else{
            challengeSolved = false
            challengeViedMode.saveWrongAsnser(for: challengeTest.challenge)
        }
        
        isChallengeReslutAlertDisplayed = true
        return challengeSolved
        
    }
}

struct ChoicesView_Previews: PreviewProvider {
    static let challengesViewModel = ChallengeViewMode()

    static var previews: some View {
      
        challengesViewModel.generateRandomChallenge()

        return ChoicesView(challengeTest: challengesViewModel.currnetChallenge!)
    }
}
