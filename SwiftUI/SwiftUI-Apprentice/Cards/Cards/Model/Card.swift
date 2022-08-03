//
//  Card.swift
//  Cards
//
//  Created by admin on 2022/7/13.
//

import SwiftUI
struct Card: Identifiable {
  var id = UUID()
  var backgroundColor: Color = .yellow
  var elements: [CardElement] = []

  mutating func remove(_ element: CardElement) {
    if let index = element.index(in: elements) {
      elements.remove(at: index)
    }
    if let element = element as? ImageElement {
      UIImage.remove(name: element.imageFileName)
    }
    save()
  }

  mutating func addElement(uiImage: UIImage) {
    let imageFileName = uiImage.save()
    let image = Image(uiImage: uiImage)
    let element = ImageElement(
      image: image,
      imageFileName: imageFileName
    )
    elements.append(element)
    save()
  }

  mutating func update(_ element: CardElement?, frame: AnyShape) {
    if let element = element as? ImageElement,
       let index = element.index(in: elements) {
      var newElemet = element
      newElemet.frame = frame
      elements[index] = newElemet
    }
    save()
  }

  func save() {
    print("Saving data")
    do {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      let data = try encoder.encode(self)
      let fileName = "\(id).rwcard"
      if let url = FileManager.documentURL?.appendingPathComponent(fileName) {
        try data.write(to: url)
      }
    } catch {
      print(error.localizedDescription)
    }
  }
  
}

extension Card: Codable {
  enum CodingKeys: CodingKey {
  case id, backgroundColor, imageElements, textElements
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let id = try container.decode(String.self, forKey: .id)
    self.id = UUID(uuidString: id) ?? UUID()
    elements += try container.decode([ImageElement].self, forKey: .imageElements)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id.uuidString, forKey: .id)
    let imageElements: [ImageElement] = elements.compactMap { $0 as? ImageElement }
    try container.encode(imageElements, forKey: .imageElements)
  }
}
