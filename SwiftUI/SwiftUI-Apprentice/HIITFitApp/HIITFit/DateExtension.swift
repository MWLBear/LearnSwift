//
//  DateExtension.swift
//  HIITFit
//
//  Created by admin on 2022/6/13.
//

import Foundation

extension Date {
  func formatted(as format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: self)
  }

  var yearMonthDay: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy MM dd"
    return dateFormatter.string(from: self)
  }

  func isSameDay(as day: Date) -> Bool {
    return self.yearMonthDay == day.yearMonthDay
  }

  var dayName: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter.string(from: self)
  }
  var truncatedDayName: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEE"
    return dateFormatter.string(from: self)
  }
  var truncatedDayMonth: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM"
    return dateFormatter.string(from: self)
  }
  var lastSevenDays: [Date] {
    (-6...0).map { day in
      Calendar.current.date(
        byAdding: .day,
        value: day,
        to: Date()) ?? Date()
    }
  }
}
