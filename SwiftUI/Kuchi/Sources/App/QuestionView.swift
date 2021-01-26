//
//  QuestionView.swift
//  Kuchi
//
//  Created by admin on 2021/1/26.
//  Copyright © 2021 Omnijar. All rights reserved.
//

import SwiftUI

struct QuestionView: View {
    var question: String
    
    var body: some View {
        Text(question)
            .font(.system(size: 64))
            .allowsTightening(true)
            .foregroundColor(.red)
            .lineLimit(5)
            .multilineTextAlignment(.center)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(question: "口")
    }
}
