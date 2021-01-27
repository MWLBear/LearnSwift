

import SwiftUI


struct CheckInInfo: Identifiable {
    let id = UUID()
    let airline: String
    let flight: String
}


struct FlightBoardInformation: View {
    
    var flight: FlightInformation
    @Binding var showModal: Bool
    @State private var rebookAlert: Bool = false
    @State private var checkInFlight: CheckInInfo?
    @State private var showFlightHistory = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(flight.airline) Flight \(flight.number)")
                    .font(.largeTitle)
                Spacer()
                Button("Done",action: {
                    self.showModal = false
                })
            }
            Text("\(flight.direction == .arrival ? "From: " : "TO: ") \(flight.otherAirport)")
            Text(flight.flightStatus)
                .foregroundColor(Color(flight.timelineColor))
            
            if flight.status == .cancelled {
                Button("Rebook Flight",action:{
                    self.rebookAlert = true
                }).alert(isPresented: $rebookAlert, content: {
                    Alert(title: Text("Contact Your Airline"), message:Text("We cannot rebook this flight. Please contact the airline to reschedule this flight"))
                })
            }
            if flight.direction == .departure && (flight.status == .ontime) || flight.status == .delayed {
                Button("Check In for Flight",action:{
                    self.checkInFlight = CheckInInfo(airline: self.flight.airline, flight: self.flight.number)
                }).actionSheet(item: $checkInFlight) { flight  in
                    
                    ActionSheet(title: Text("Check In"),
                                message: Text("Check In for \(flight.airline) Flight \(flight.flight)"),
                                buttons: [
                                    .cancel(Text("Not Now")),
                                    .destructive(Text("Reschedlue"),action: {
                                        print("Reschedule flight.")
                                    }),
                                    .default(Text("Check In"),action: {
                                        print("Check-in for \(flight.airline) \(flight.flight).")
                                    })
                                ])
                }
            }
            
           
            Button("On-Time History"){
                self.showFlightHistory.toggle()
            }.popover(isPresented: $showFlightHistory, arrowEdge: .top,content: {
                FlightTimeHistory(flight: self.flight)
            })
            Spacer()
        }.font(.headline).padding(10)
        
        
    }
}

struct FlightBoardInformation_Previews: PreviewProvider {
    static var previews: some View {
        FlightBoardInformation(flight: FlightInformation.generateFlight(0),
                               showModal: .constant(true))
    }
}
