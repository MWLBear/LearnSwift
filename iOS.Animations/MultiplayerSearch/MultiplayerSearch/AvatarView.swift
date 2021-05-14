
import UIKit
import QuartzCore

@IBDesignable
class AvatarView: UIView {
  
  //constants
  let lineWidth: CGFloat = 6.0
  let animationDuration = 1.0
  
  //ui
  let photoLayer = CALayer()
  let circleLayer = CAShapeLayer()
  let maskLayer = CAShapeLayer()
  let label: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "ArialRoundedMTBold", size: 18.0)
    label.textAlignment = .center
    label.textColor = UIColor.black
    return label
  }()
  
  //variables
  @IBInspectable
  var image: UIImage? = nil {
    didSet {
      photoLayer.contents = image?.cgImage
    }
  }
  
  @IBInspectable
  var name: String? = nil {
    didSet {
      label.text = name
    }
  }
  
  var shouldTransitionToFinishedState = false
  
  override func didMoveToWindow() {
    photoLayer.backgroundColor = UIColor.red.cgColor
    layer.addSublayer(photoLayer)
   // photoLayer.mask = maskLayer
   // layer.addSublayer(circleLayer)
    addSubview(label)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    guard let image = image else {
      return
    }
    
    //Size the avatar image to fit
    photoLayer.frame = CGRect(
      x: (bounds.size.width - image.size.width + lineWidth)/2,
      y: (bounds.size.height - image.size.height - lineWidth)/2,
      width: image.size.width,
      height: image.size.height)
    
    //Draw the circle
    circleLayer.path = UIBezierPath(ovalIn: bounds).cgPath
    circleLayer.strokeColor = UIColor.white.cgColor
    circleLayer.lineWidth = lineWidth
    circleLayer.fillColor = UIColor.clear.cgColor
    
    //Size the layer
    maskLayer.path = circleLayer.path
    maskLayer.position = CGPoint(x: 0.0, y: 20)
    
    //Size the label
    label.frame = CGRect(x: 0.0, y: bounds.size.height + 10.0, width: bounds.size.width, height: 24.0)
  }
  
}
