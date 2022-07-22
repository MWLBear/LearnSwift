//
//  CardModal.swift
//  Cards
//
//  Created by admin on 2022/6/29.
//

import Foundation
enum CardModal: Identifiable {
  var id: Int {
    hashValue
  }
  case photoPicker, framePicker, stickerPicker, textPicker
}
