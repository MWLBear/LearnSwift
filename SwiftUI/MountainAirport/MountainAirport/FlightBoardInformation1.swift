

import SwiftUI

extension AnyTransition {
    static var flightDetailsTransition: AnyTransition {
//        AnyTransition.slide
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.scale(scale: 0)
            .combined(with: .opacity)
        
        return .asymmetric(insertion: insertion, removal: removal)
    }
}


struct FlightBoardInformation1: View {
    
    var flightDetailAnimation: Animation{
        Animation.easeInOut
    }

    @State private var showDetails = false
    var flight: FlightInformation
    @Binding var dismissFlag: Bool
    
    var body: some View {
        VStack(alignment:.leading){
            HStack {
                Text("\(flight.airline) Flight \(flight.airline)").font(.largeTitle)
                Spacer()
                Button("Done",action:{
                    self.dismissFlag.toggle()
                })
            }
            Text("\(flight.direction == .arrival ? "From: " : "To: ") \(flight.otherAirport)")
            Text(flight.flightStatus)
            Button(action: {
                withAnimation{
                    self.showDetails.toggle()
                }
            }){
                HStack {
                    Text(showDetails ? "Hide Details" : "Show Details")
                    Spacer()
                    
                    Image(systemName: "chevron.up.square")
                        .scaleEffect(showDetails ? 2 : 1)
                       // .animation(.spring())
                        .rotationEffect(.degrees(showDetails ? 0 : 180))
                        .animation(flightDetailAnimation)

                }
            }
            if showDetails {
                FlightDetails(flight: flight)
                    //.animation(.easeOut(duration: 2))
                    .transition(.flightDetailsTransition)
                  
                   
            }
            Spacer()
        }.font(.headline).padding(10)
    }
}

struct FlightBoardInformation1_Previews: PreviewProvider {
    @State static var isPresented =  true
    static var previews: some View {
        FlightBoardInformation1(flight: FlightInformation.generateFlight(0), dismissFlag: $isPresented)
    }
}
