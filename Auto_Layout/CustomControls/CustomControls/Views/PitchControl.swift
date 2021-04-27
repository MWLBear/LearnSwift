

import UIKit

final class PitchControl: UIControl {
  // MARK: - IBOutlets
  @IBOutlet var thumbImageView: UIImageView!
  @IBOutlet var sliderBackgroundImageView: UIImageView!
  @IBOutlet var thumbImageViewTopConstraint: NSLayoutConstraint!
  
  // MARK: - Private UI Properties
  private lazy var view = instantiateNib(view: self)
  
  // MARK: - Private Data Properties
  private let minValue: CGFloat = 0
  private let maxVaule: CGFloat = 10
  private var value: CGFloat = 1 {
    didSet {
      print("Vaule:", value)
    }
  }
  private var previousTouchLocation = CGPoint()
  // MARK: - Private Computed Properties
  private var valueRange: CGFloat {
    return maxVaule - minValue + 1
  }
  private var halfTumbImageHeight: CGFloat {
    return thumbImageView.bounds.height / 2
  }
  private var distancePerUnit: CGFloat {
    return (sliderBackgroundImageView.bounds.height / valueRange) - (halfTumbImageHeight / 2)
  }
  // MARK: - Internal Properties
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    addSubview(view)
    view.isUserInteractionEnabled = false
    view.fillSuperview(self)
  }
  
  // MARK: - Touch Tracking Handlers
  override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    super.beginTracking(touch, with: event)
    previousTouchLocation = touch.location(in: self)
    let isTouchingThumbImageView = thumbImageView.frame.contains(previousTouchLocation)
    thumbImageView.isHighlighted = isTouchingThumbImageView
    return isTouchingThumbImageView
  }
  
  override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    super.continueTracking(touch, with: event)
    let touchLocation = touch.location(in: self)
    let deltaLocation = touchLocation.y - previousTouchLocation.y
    let deltaVaule = (maxVaule - minValue) * deltaLocation / bounds.height
    previousTouchLocation = touchLocation

    value = boundValue(value+deltaVaule, toLowerValue: minValue, andUpperValue: maxVaule)
    let isTouchingBackgroundImage = sliderBackgroundImageView.frame.contains(previousTouchLocation)
    if isTouchingBackgroundImage {
      thumbImageViewTopConstraint.constant = touchLocation.y - self.halfTumbImageHeight
    }
    return true
  }
  
  override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
    super.endTracking(touch, with: event)
    thumbImageView.isHighlighted = false
  }
  
  // MARK: - Accessibility Features
  
  // MARK: - Helpers
  private func boundValue(
    _ value: CGFloat,
    toLowerValue lowerValue: CGFloat,
    andUpperValue upperValue: CGFloat) -> CGFloat {
    return min(max(value, lowerValue), upperValue)
  }
}
