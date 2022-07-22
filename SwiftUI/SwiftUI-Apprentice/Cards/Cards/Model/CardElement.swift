//
//  CardElement.swift
//  Cards
//
//  Created by admin on 2022/7/13.
//

import SwiftUI
protocol CardElement {
  var id: UUID { get }
  var transform: Transform { get set }
}

extension CardElement {
  func index(in arrary: [CardElement]) -> Int? {
    arrary.firstIndex { $0.id == id}
  }
}

struct ImageElement: CardElement {
  let id: UUID = UUID()
  var transform = Transform()
  var image: Image
  var frame: AnyShape?
}

struct TextElement: CardElement {
  let id = UUID()
  var transform = Transform()
  var text = ""
  var textColor = Color.black
  var textFont = "San Fransisco"
}


