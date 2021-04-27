import UIKit

extension UIView {
  func instantiateNib<T:UIView>(view: T) -> UIView {
    let type = T.self
    let nibName = String(describing: type)
    let bundle = Bundle(for: type)
    let nib = UINib(nibName: nibName, bundle: bundle)
    guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
      fatalError("Failed to instantiate: \(nibName)")
    }
    return view
  }
}
