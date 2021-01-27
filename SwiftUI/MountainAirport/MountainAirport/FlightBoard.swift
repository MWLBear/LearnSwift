

import SwiftUI

struct FlightBoard: View {
    var boardName: String
    var fightData: [FlightInformation]
    @State private var hideCancled = false
    var showFlights: [FlightInformation] {
        hideCancled ? fightData.filter{ $0.status != .cancelled} : fightData
    }
    
    
    var body: some View {
        //        VStack {
        //            List(showFlights){ fl in
        //                NavigationLink(
        //                    destination: FlightBoardInformation(flight: fl),
        //                    label: {
        //                        FlightRow(flight: fl)
        //                    })
        //            }.navigationBarTitle(boardName)
        //            .navigationBarItems(trailing:
        //                                    Toggle(isOn: $hideCancled, label: {
        //                                        Text("Hide Canceled")
        //                                    })
        //            )
        //        }
        
        VStack {
            List(showFlights){ fl in
                FlightRow(flight: fl)
            }.navigationBarTitle(boardName)
            .navigationBarItems(trailing:
                                    Toggle(isOn: $hideCancled, label: {
                                        Text("Hide Canceled")
                                    }))
        }
    }
}

struct FlightBoard_Previews: PreviewProvider {
    static var previews: some View {
        FlightBoard(boardName: "Test", fightData: FlightInformation.generateFlights())
    }
}
