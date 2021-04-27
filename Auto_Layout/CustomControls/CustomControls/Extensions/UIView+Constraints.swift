
import UIKit

extension UIView {
  func fillSuperview(_ superview: UIView, withConstant constant: CGFloat = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate(
      [leadingAnchor.constraint(
        equalTo: superview.leadingAnchor,
        constant: constant),
       topAnchor.constraint(
        equalTo: superview.topAnchor,
        constant: constant),
       trailingAnchor.constraint(
        equalTo: superview.trailingAnchor,
        constant: -constant),
       bottomAnchor.constraint(
        equalTo: superview.bottomAnchor,
        constant: -constant)]
    )
  }
  
  func center(_ superview: UIView) {
    translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate(
      [centerXAnchor.constraint(
        equalTo: superview.centerXAnchor),
       centerYAnchor.constraint(
        equalTo: superview.centerYAnchor),
       topAnchor.constraint(
        greaterThanOrEqualTo: superview.topAnchor),
       leadingAnchor.constraint(
        greaterThanOrEqualTo: superview.leadingAnchor),
       trailingAnchor.constraint(
        lessThanOrEqualTo: superview.trailingAnchor),
       bottomAnchor.constraint(
        lessThanOrEqualTo: superview.bottomAnchor)
      ]
    )
  }
}
