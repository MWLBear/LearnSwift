

import SwiftUI

struct AirportAwards: View {
    var body: some View {
        VStack {
            ScrollView {
                FirstVisitAward()
                    .frame(width: 250, height: 250)
                Text("First Visit")
                
                OverNightParkAward().frame(width: 250, height: 250)
                Text("Left Car Overnnight")
                
                AirportMealAward().frame(width: 250, height: 250)
                Text("Ate Meal at Airport")
            }
            
        }.navigationBarTitle(Text("Your Awards"))
    }
}

struct AirportAwards_Previews: PreviewProvider {
    static var previews: some View {
        AirportAwards()
    }
}
