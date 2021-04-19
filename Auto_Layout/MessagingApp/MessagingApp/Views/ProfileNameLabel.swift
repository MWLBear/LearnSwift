

import UIKit

@IBDesignable final class ProfileNameLabel: UILabel {
  // MARK: - Properties
  @IBInspectable private var isMultipleLine: Bool = false {
    didSet {
      isMultipleLineDidSet()
    }
  }
  
  // MARK: - Views Setup
  private func isMultipleLineDidSet() {
    switch isMultipleLine {
    case true:
      numberOfLines = 0
      guard let words = text?.components(separatedBy: .whitespaces) else { return }
      let joinedWords = words.joined(separator: "\n")
      text = joinedWords
    case false:
      numberOfLines = 1
    }
  }
}
