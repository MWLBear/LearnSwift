//
//  CardDrop.swift
//  Cards
//
//  Created by admin on 2022/7/18.
//

import SwiftUI

struct CardDrop: DropDelegate {
  @Binding var card: Card

  func performDrop(info: DropInfo) -> Bool {
    let itemProviders = info.itemProviders(for: [.image])
    for item in itemProviders {
      if item.canLoadObject(ofClass: UIImage.self) {
        item.loadObject(ofClass: UIImage.self) { image, error in
          if let image = image as? UIImage {
            DispatchQueue.main.async {
              print("image:\(image)")
              card.addElement(uiImage: image)
            }
          }
        }
      }
    }
    return true
  }
}
