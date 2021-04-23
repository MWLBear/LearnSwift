

import Foundation

struct Contact {
  var name: String
  var photo: String
  var lastMessage: String
  var lastTime: Date
  
  var formattedDate: String {
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "MM-dd-yyyy hh:mm a"
    return dateformatter.string(from: lastTime)
  }
  
}
