//
//  ColorExtension.swift
//  Cards
//
//  Created by admin on 2022/7/13.
//

import SwiftUI

extension Color {
  static let colors: [Color] = [
    .green, .red, .blue, .gray, .yellow, .pink, .orange, .purple
  ]
  static func random() -> Color{
    return colors.randomElement() ?? .black
  }
}
