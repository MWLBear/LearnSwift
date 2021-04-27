
import UIKit

final class BacklitButton: UIButton {
  // MARK: - Animations
  private func shrinkAnimation(){
    let scale: CGFloat = 0.9
    UIView.animate(withDuration: 0.2) { [weak self] in
      self?.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
  }
  private func resetAnimation(){
    UIView.animate(withDuration: 0.2) { [weak self] in
      self?.transform = .identity
    }
  }
  // MARK: - Custom Touch Handling
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    shrinkAnimation()
  }
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    resetAnimation()
  }
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesCancelled(touches, with: event)
    resetAnimation()
  }
}
