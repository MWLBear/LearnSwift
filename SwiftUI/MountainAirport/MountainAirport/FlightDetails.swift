
import SwiftUI

struct FlightDetails: View {
    var flight: FlightInformation
    
    var body: some View {
        VStack(alignment:.leading) {
            Text("\(flight.direction == .arrival ? "Arriving ar" : "Departing from") Gate: \(flight.gate)")
            Text("Scheduled; \(flight.scheduledTimeString)")
            Text("Current: \(flight.currentTimeString)")
            Text("Terminal Map").font(.title)
            Image(flight.gate.starts(with: "A") ? "terminal-a-map" : "terminal-b-map")
            
            ForEach(flight.history[0...5],id: \.day){ h in
                Text("On \(h.shortDate) flight was \(h.status.rawValue)")
            }
        }
    }
}

struct FlightDetails_Previews: PreviewProvider {
    static var previews: some View {
        FlightDetails(flight: FlightInformation.generateFlight(0))
    }
}
