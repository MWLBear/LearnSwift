

import SwiftUI

struct FlightRow: View {
    var flight: FlightInformation
    @State private var isPresented = false
    var body: some View {
        
        
        Button(action:{
            self.isPresented.toggle()
        }){
            HStack {
                Text("\(self.flight.airline) \(self.flight.number)")
                    .frame(width: 120, alignment: .leading)
                Text(self.flight.otherAirport).frame(alignment: .leading)
                Spacer()
                Text(self.flight.flightStatus).frame(alignment: .leading)
            }.sheet(isPresented: $isPresented, onDismiss: {
                print("Modal dismissed. State Now: \(self.isPresented)")
            }, content: {
//                FlightBoardInformation(flight: self.flight,showModal: $isPresented)
                FlightBoardInformation1(flight: self.flight, dismissFlag: $isPresented)
            })
        }
    }
    
}

struct FlightRow_Previews: PreviewProvider {
    static var previews: some View {
        FlightRow(flight: FlightInformation.generateFlight(0))
    }
}
