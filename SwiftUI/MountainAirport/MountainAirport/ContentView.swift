

import SwiftUI

struct ContentView: View {
  var flightInfo: [FlightInformation] = FlightInformation.generateFlights()
  
  var body: some View {
//    TabView {
//      FlightBoard(boardName: "Arrivals")
//        .tabItem {
//          Image(systemName: "icloud.and.arrow.down").resizable()
//          Text("Arrivals")
//        }
//      FlightBoard(boardName: "Departures")
//        .tabItem {
//          Image(systemName: "icloud.and.arrow.up").resizable()
//          Text("Departures")
//        }
//    }
    
    NavigationView {
      ZStack {
        Image(systemName: "airplane").resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 250, height: 250, alignment: .center)
          .opacity(0.1).rotationEffect(.degrees(-90))
        
        VStack(alignment: .leading, spacing: 5, content: {
          NavigationLink(
            destination: FlightBoard(boardName: "Arrivals",fightData: self.flightInfo.filter{ $0.direction == .arrival}),
            label: {
                Text("Arrivals")
            })
          NavigationLink(
            destination: FlightBoard(boardName: "Departures",fightData: self.flightInfo.filter{$0.direction == .departure}),
            label: {
                Text("Departures")
            })
          
          NavigationLink(
            destination: FlightTimeline(flights: self.flightInfo),
            label: {
              Text("Flight TimeLine")
            })
          NavigationLink(
            destination: AirportAwards(),
            label: {
              Text("Awards")
            })
          Spacer()
          
        }).font(.title).padding(20)
        
        Spacer()
      }.navigationBarTitle(Text("Nountain Airport"))
    }
    
    
  }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
#endif


