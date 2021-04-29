//
//  HeroImage.swift
//  SavannaTours
//
//  Created by admin on 2021/4/28.
//

import SwiftUI

struct HeroImage: View {
    let name: String
    
    var body: some View {
       Image(name)
        .resizable()
        .edgesIgnoringSafeArea(.top)
        .frame(height:300)
    }
}

struct HeroImage_Previews: PreviewProvider {
    static var previews: some View {
        HeroImage(name: "hero")
    }
}
