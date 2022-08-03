//
//  AnyShape.swift
//  Cards
//
//  Created by admin on 2022/7/19.
//

import SwiftUI

struct AnyShape: Shape {
  private let path: (CGRect) -> Path
  init<CustomShape: Shape>(_ shape: CustomShape) {
    self.path = { rect in
      shape.path(in: rect)
    }
  }
  func path(in rect: CGRect) -> Path {
    path(rect)
  }
}

extension AnyShape: Equatable {
  static func == (lhs: AnyShape, rhs: AnyShape) -> Bool {
    let rect = CGRect(
      origin: .zero,
      size: CGSize(width: 100, height: 100))
    let lhsPath = lhs.path(in: rect)
    let rhsPath = rhs.path(in: rect)
    return lhsPath == rhsPath
  }
}
