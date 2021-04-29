//
//  MiletonesList.swift
//  SavannaTours
//
//  Created by admin on 2021/4/28.
//

import SwiftUI

struct MiletonesList: View {
   
    var body: some View {
        List((0...4), id: \.self) { num in
            VStack(alignment:.leading) {
                Text("Milestone #\(num+1)")
                    .font(.title)
                HStack(alignment: .lastTextBaseline) {
                    Text("Savanna National Park (\(num*12 + 5)km)")
                        .font(.subheadline)
                    Image(systemName: "pin")
                    Spacer()
                    Text("South Africa")
                        .font(.subheadline)
                }
            }.padding()
        }
    }
}

struct MiletonesList_Previews: PreviewProvider {
    static var previews: some View {
        MiletonesList()
    }
}
