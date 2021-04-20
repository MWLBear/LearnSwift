

import UIKit

final class ProfileImageView: UIImageView {
  // MARK: - Value Types
  enum BorderShape: String {
    case circle, squircle,none
  }
  let boldBorder:Bool

  // MARK: - Properties
  var hasBorder: Bool = false {
    didSet {
      guard hasBorder else { return layer.borderWidth = 0}
      layer.borderWidth = boldBorder ? 10 : 2
    }
  }
  
  private var borderShape: BorderShape
  
  // MARK: - Initializers
  init(borderShape:BorderShape,boldBorder:Bool = true) {
    self.borderShape = borderShape
    self.boldBorder = boldBorder
    super.init(frame: CGRect.zero)
    backgroundColor = .lightGray
  }
  
  convenience init() {
    self.init(borderShape: .none)
  }
  required init?(coder: NSCoder) {
    self.borderShape = .none
    self.boldBorder = false
    super.init(coder: coder)
    
  }
  // MARK: - Setup Views
  override func layoutSubviews() {
    super.layoutSubviews()
    setupBorderShape()
  }
  
  // MARK: - Views Setup
  private func setupBorderShape() {
    hasBorder = borderShape != .none
    let width = frame.size.width
    let divisor: CGFloat
    switch borderShape {
    case .circle:
      divisor = 2
    case .squircle:
      divisor = 4
    case .none:
      divisor = width
    }
    let cornerRadius = width / divisor
    layer.cornerRadius = cornerRadius
  }
}
