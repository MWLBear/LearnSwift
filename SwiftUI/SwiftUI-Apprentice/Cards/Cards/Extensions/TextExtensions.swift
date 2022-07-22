//
//  TextExtensions.swift
//  Cards
//
//  Created by admin on 2022/7/13.
//

import SwiftUI

extension Text {
  func scalableText(font: Font = Font.system(size: 1000)) -> some View {
    self
      .font(font)
      .minimumScaleFactor(0.01)
      .lineLimit(1)
  }
}

