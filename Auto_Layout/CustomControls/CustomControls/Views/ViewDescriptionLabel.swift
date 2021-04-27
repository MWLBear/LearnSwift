

import UIKit

final class ViewDescriptionLabel: UILabel {
  // MARK: - Initializerss
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    font = UIFont.preferredFont(forTextStyle: .largeTitle)
    minimumScaleFactor = 0.2
    textAlignment = .center
    textColor = .secondaryLabel
    backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(0.3)
  }
}
