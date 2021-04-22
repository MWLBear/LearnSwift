
import UIKit
extension UIView {
  func fillSuperView(withConstant constant:CGFloat = 0)  {
    guard let superView = superview else { return }
    translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      leadingAnchor.constraint(equalTo: superView.leadingAnchor,constant: constant),
      topAnchor.constraint(equalTo: superView.topAnchor,constant: constant),
      trailingAnchor.constraint(equalTo: superView.trailingAnchor,constant: constant),
      bottomAnchor.constraint(equalTo: superView.bottomAnchor,constant: constant),

    ])
  }
}
