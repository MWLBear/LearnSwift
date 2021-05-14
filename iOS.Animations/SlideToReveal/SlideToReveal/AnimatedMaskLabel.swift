
import UIKit
import QuartzCore

@IBDesignable
class AnimatedMaskLabel: UIView {
    
    let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        // Configure the gradient here
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        let colors = [
            UIColor.yellow.cgColor,
            UIColor.green.cgColor,
            UIColor.orange.cgColor,
            UIColor.cyan.cgColor,
            UIColor.red.cgColor,
            UIColor.yellow.cgColor,
        ]
        let locations: [NSNumber] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.25]
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        return gradientLayer
    }()
    
    let textAttributes: [NSAttributedString.Key: Any] = {
       let style = NSMutableParagraphStyle()
        style.alignment = .center
        return [
            .font: UIFont(name: "HelveticaNeue-Thin", size: 28.0)!,
            .paragraphStyle: style
        ]
    }()
    
    @IBInspectable var text: String! {
        didSet {
            setNeedsDisplay()
            let image = UIGraphicsImageRenderer(size: bounds.size).image { _ in
                text.draw(in: bounds, withAttributes: textAttributes)
            }
            let maskLayer = CALayer()
            maskLayer.backgroundColor = UIColor.clear.cgColor
            maskLayer.frame = bounds.offsetBy(dx: bounds.size.width, dy: 0)
            maskLayer.contents = image.cgImage
            gradientLayer.mask = maskLayer
        }
    }
    
    override func layoutSubviews() {
        layer.borderColor = UIColor.green.cgColor
        gradientLayer.frame = CGRect(x: -bounds.size.width, y: bounds.origin.y, width: 3*bounds.size.width, height: bounds.size.height)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        layer.addSublayer(gradientLayer)
        
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [0.0, 0.0, 0.0, 0.0, 0.0, 0.25]
        gradientAnimation.toValue = [0.65, 0.8, 0.85, 0.9, 0.95, 1.0]
        gradientAnimation.duration = 3.0
        gradientAnimation.repeatCount = Float.infinity
        gradientLayer.add(gradientAnimation, forKey: nil)
    }
    
}
