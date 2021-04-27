import UIKit
extension UIView {
  func addLabelDescribing<T: UIView>(view: T, insideSuperview superview: UIView) {
    let viewDescriptionLabel = ViewDescriptionLabel()
    viewDescriptionLabel.text = String(describing: T.self)
    superview.addSubview(viewDescriptionLabel)
    viewDescriptionLabel.center(superview)
  }
}
