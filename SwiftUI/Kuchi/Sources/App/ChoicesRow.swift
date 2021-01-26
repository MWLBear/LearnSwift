//
//  ChoicesRow.swift
//  Kuchi
//
//  Created by admin on 2021/1/26.
//  Copyright © 2021 Omnijar. All rights reserved.
//

import SwiftUI

struct ChoicesRow: View {
    var choice: String
    
    var body: some View {
        Text(choice)
            .font(.largeTitle )
    }
}

struct ChoicesRow_Previews: PreviewProvider {
    static var previews: some View {
        ChoicesRow(choice: "Hello")
    }
}
