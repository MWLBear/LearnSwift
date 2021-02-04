import SwiftUI

struct FlightTimeline: UIViewControllerRepresentable {
    
    var flights: [FlightInformation]
    
    func makeCoordinator() -> Coordinator {
        Coordinator(flights: flights)
    }
    
    func makeUIViewController(context: Context) -> UITableViewController {
           
        UITableViewController()
    }
    
    func updateUIViewController(_ uiViewController: UITableViewController, context: Context) {
        uiViewController.tableView.dataSource = context.coordinator
        
        let timelineTableViewCellNib = UINib(nibName: "TimelineTableViewCell", bundle: Bundle.main)
        uiViewController.tableView.register(timelineTableViewCellNib, forCellReuseIdentifier: "TimelineTableViewCell")
        
    }
    

    
}

class Coordinator: NSObject {
    var flightData: [FlightInformation]
    
    init(flights: [FlightInformation]){
        self.flightData = flights
    }
}

extension Coordinator: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flightData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        timeFormatter.dateStyle = .none
        
        let flight = self.flightData[indexPath.row]
        let scheduledString = timeFormatter.string(from: flight.scheduledTime)
        let currentString = timeFormatter.string(from: flight.currentTime ?? flight.scheduledTime)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineTableViewCell" ,for: indexPath) as! TimelineTableViewCell

        var flightInfo = "\(flight.airline) \(flight.number)"
        flightInfo = flightInfo + "\(flight.direction == .departure ? "to" : "from")"
        flightInfo = flightInfo + "\(flight.otherAirport)"
        flightInfo = flightInfo + " - \(flight.flightStatus)"
        cell.descriptionLabel.text = flightInfo
        
        if flight.status == .cancelled {
            cell.titleLabel.text = "Cancelled"
        } else if flight.timeDifference != 0 {
            if flight.status == .cancelled {
                cell.titleLabel.text = "Cancelled"
                
            } else if flight.timeDifference != 0 {
                var title = "\(scheduledString)"
                title = title + " Now: \(currentString)"
                cell.titleLabel.text = title
            } else { cell.titleLabel.text =
                "On Time for \(scheduledString)"
            }      } else {
                cell.titleLabel.text =
                    "On Time for \(scheduledString)"
            }
        cell.titleLabel.textColor = UIColor.black
        cell.bubbleColor = flight.timelineColor
        return cell
        
        
    }
}
#if DEBUG
struct FlightTimeLine_Previews: PreviewProvider {
  static var previews: some View {
    FlightTimeline(flights: FlightInformation.generateFlights())
  }
}
#endif

