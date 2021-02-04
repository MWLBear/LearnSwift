

import SwiftUI

struct AirportAwards: View {
    var awardArray: [AwardInformation] {
      var awardList: [AwardInformation] = []
      
      awardList.append(AwardInformation(awardView: AnyView(FirstVisitAward()),
                                        title: "First Visit",
                                        description: "Awarded the first time you open the app while at the airport.",
                                        awarded: true))
      awardList.append(AwardInformation(awardView: AnyView(OverNightParkAward()),
                                        title: "Left Car Overnight",
                                        description: "You left you car parked overnight in one of our parking lots.",
                                        awarded: true))
      awardList.append(AwardInformation(awardView: AnyView(AirportMealAward()),
                                        title: "Meal at Airport",
                                        description: "You used the app to receive a discount at one of our restaurants.",
                                        awarded: true))
      awardList.append(AwardInformation(awardView: AnyView(FirstFlightAward()),
                                        title: "First Flight",
                                        description: "You checked in for a flight using the app for the first time.",
                                        awarded: true))
      awardList.append(AwardInformation(awardView: AnyView(HypocycloidView(R: 4.0, r: 2.0, color: Color.purple)),
                                        title: "Almost Duty Free",
                                        description: "You used the app to receive a discount at one of our vendors.",
                                        awarded: true))
      awardList.append(AwardInformation(awardView: AnyView(HypocycloidView(R: 8.0, r: 3.0, color: Color.blue)),
                                        title: "Rainy Day",
                                        description: "You flight was delayed because of weather.",
                                        awarded: true))
      awardList.append(AwardInformation(awardView: AnyView(HypocycloidView(R: 16.0, r: 5.0, color: Color.yellow)),
                                        title: "Welcome Home",
                                        description: "Your returned to the airport after leaving from it.",
                                        awarded: true))
      return awardList
    }
    
    var activeAwards: [AwardInformation] {
      awardArray.filter { $0.awarded }
    }
    
    var body: some View {
//        VStack {
//            ScrollView {
//                FirstVisitAward()
//                    .frame(width: 250, height: 250)
//                Text("First Visit")
//
//                OverNightParkAward().frame(width: 250, height: 250)
//                Text("Left Car Overnnight")
//
//                AirportMealAward().frame(width: 250, height: 250)
//                Text("Ate Meal at Airport")
//            }
//
//        }.navigationBarTitle(Text("Your Awards"))
        
        VStack{
            Text("Your Awards (\(activeAwards.count))")
                .font(.title)
            GridView(colums: 2, items: activeAwards) { item in
                VStack {
                    item.awardView
                    Text(item.title)
                }.padding(5)
            }
        }
    }
}

struct AirportAwards_Previews: PreviewProvider {
    static var previews: some View {
        AirportAwards()
    }
}
