
import SwiftUI

struct FlightDetails: View {
    var flight: FlightInformation
    
    var body: some View {
        VStack(alignment:.leading) {
            Text("\(flight.direction == .arrival ? "Arriving ar" : "Departing from") Gate: \(flight.gate)")
            Text("Scheduled; \(flight.scheduledTimeString)")
            Text("Current; \(flight.currentTimeString)")
            Image(flight.gate.starts(with: "A") ? "terminal-a-map" : "terminal-b-map")
        }
    }
}

struct FlightDetails_Previews: PreviewProvider {
    static var previews: some View {
        FlightDetails(flight: FlightInformation.generateFlight(0))
    }
}
