//
//  TourTitle.swift
//  SavannaTours
//
//  Created by admin on 2021/4/28.
//

import SwiftUI

struct TourTitle: View {
    let title: String
    let caption: String
    
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .shadow(radius: 5)
                .foregroundColor(.white)
            Text(caption)
                .font(.caption)
                .foregroundColor(.white)
        }
    }
}

struct TourTitle_Previews: PreviewProvider {
    static var previews: some View {
        TourTitle(title: "Savanna Trek", caption: "15 mile drive followed by an hour long trek")
    }
}
