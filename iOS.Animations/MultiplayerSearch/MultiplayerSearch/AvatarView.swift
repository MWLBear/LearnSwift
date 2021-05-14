
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
    var isSquare = false
    
    override func didMoveToWindow() {
        layer.addSublayer(photoLayer)
        photoLayer.mask = maskLayer
        layer.addSublayer(circleLayer)
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
        maskLayer.position = CGPoint(x: 0.0, y: 10)
        
        //Size the label
        label.frame = CGRect(x: 0.0, y: bounds.size.height + 10.0, width: bounds.size.width, height: 24.0)
    }
    
    func bounceOff(point: CGPoint, morphSize: CGSize) {
        let originalCenter = center
        UIView.animate(withDuration: animationDuration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0) {
            self.center = point
        } completion: { _ in
            if self.shouldTransitionToFinishedState {
                print("shouldTransitionToFinishedState")
               self.animateToSquare()
            }
        }

        UIView.animate(withDuration: animationDuration, delay: animationDuration, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: []) {
            self.center = originalCenter
        } completion: { _ in
            delay(seconds: 0.1) {
                if !self.isSquare {
                    self.bounceOff(point: point, morphSize: morphSize)
                }
            }
        }
        let morphedFrame = (originalCenter.x > point.x) ?
            CGRect(x: 0.0, y: bounds.height - morphSize.height, width: morphSize.width, height: morphSize.height) :
            CGRect(x: bounds.width - morphSize.width, y: bounds.height - morphSize.height, width: morphSize.width, height: morphSize.height)
        let morphAnimation = CABasicAnimation(keyPath: "path")
        morphAnimation.duration = animationDuration
        morphAnimation.toValue = UIBezierPath(ovalIn: morphedFrame).cgPath
        morphAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        circleLayer.add(morphAnimation, forKey: nil)
        maskLayer.add(morphAnimation, forKey: nil)
    }
    
    func animateToSquare(){
        isSquare = true
        let squarePath = UIBezierPath(rect: bounds).cgPath
        let squareAnimation = CABasicAnimation(keyPath: "path")
        squareAnimation.duration = 0.25
        squareAnimation.fromValue = circleLayer.path
        squareAnimation.toValue = squarePath
        circleLayer.add(squareAnimation, forKey: nil)
        maskLayer.add(squareAnimation, forKey: nil)
       
        circleLayer.path = squarePath
        maskLayer.path = squarePath
    }
}
