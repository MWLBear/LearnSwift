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
  var imageFileName: String?
}

struct TextElement: CardElement {
  let id = UUID()
  var transform = Transform()
  var text = ""
  var textColor = Color.black
  var textFont = "San Fransisco"
}

extension ImageElement: Codable {
  enum CodingKeys: CodingKey {
    case transform, imageFileName, frame
  }
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    transform = try container.decode(Transform.self, forKey: .transform)
    imageFileName = try container.decodeIfPresent(String.self, forKey: .imageFileName)

    if let imageFileName = imageFileName ,
       let uiImage = UIImage.load(uuidString: imageFileName) {
      image = Image(uiImage: uiImage)
    } else {
      image = Image("error-image")
    }
    if let index =
      try container.decodeIfPresent(Int.self, forKey: .frame) {
      frame = Shapes.shapes[index]
    }

  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(transform, forKey: .transform)
    try container.encode(imageFileName, forKey: .imageFileName)
    if let index = Shapes.shapes.firstIndex(where: { $0 == frame }) {
      try container.encode(index, forKey: .frame)
    }
  }
}
