

import SwiftUI

struct FlightTimeHistory: View {
  var flight: FlightInformation
  
  var body: some View {
    VStack {
      Text("On-Time History for \(flight.airline) Flight \(flight.number)")
      List(flight.history, id:\.day) { h in
        HStack{
          Text("\(h.day) day ago - \(h.flightDelayDescription)")
          Spacer()
        }.background(h.delayColor.opacity(0.3))
      }.frame(height: 400)
    }
  }
}

struct FlightTimeHistory_Previews: PreviewProvider {
  static var previews: some View {
    FlightTimeHistory(flight: FlightInformation.generateFlight())
  }
}
