//
//  LogoImage.swift
//  Kuchi
//
//  Created by admin on 2021/1/29.
//  Copyright © 2021 Omnijar. All rights reserved.
//

import SwiftUI

struct LogoImage: View {
    var body: some View {
        Image(systemName: "table")
            .resizable()
            .frame(width: 60, height: 60 ,alignment: .center)
            .border(Color.gray,width: 1)
            .cornerRadius(60 / 2)
            .background(Color(white: 0.9))
            .clipShape(Circle())
            .foregroundColor(.red)
    }
}

struct LogoImage_Previews: PreviewProvider {
    static var previews: some View {
        LogoImage()
    }
}
