

import UIKit

@IBDesignable final class ProfileImageView: UIImageView {
  // MARK: - Value Types
  private enum BorderShape: String {
    case circle, squircle
  }
  
  // MARK: - Properties
  @IBInspectable private var hasBorder: Bool = false {
    didSet {
      layer.borderWidth = hasBorder ? 10 : 0
    }
  }
  
  @IBInspectable private var borderShape: String = "" {
    didSet {
      borderShapeDidSet()
    }
  }
  
  // MARK: - Initializers
  override func awakeFromNib() {
    super.awakeFromNib()
    layer.masksToBounds = true
  }
  
  // MARK: - Views Setup
  private func borderShapeDidSet() {
    let width = frame.size.width
    let divisor: CGFloat
    switch borderShape {
    case BorderShape.circle.rawValue:
      divisor = 2
    case BorderShape.squircle.rawValue:
      divisor = 4
    default:
      divisor = width
    }
    let cornerRadius = width / divisor
    layer.cornerRadius = cornerRadius
  }
}
