import UIKit
import PlaygroundSupport

let size = CGSize(width: 300 , height: 200)
let frame = CGRect(origin: .zero, size: size)
let view = UIView(frame: frame)
view.backgroundColor = .gray

let image = UIImage(named: "balloon")
let imageView = UIImageView(image: image)
imageView.center = view.center

UIView.animate(withDuration: 1.0) {
   
    imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
    imageView.transform = CGAffineTransform(translationX: 0, y: -256)
    imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
} completion: { _ in
    imageView.transform = CGAffineTransform.identity

}
let refreshRadius = frame.size.height/2 * 0.5
let bezierPath = UIBezierPath()
bezierPath.move(to: CGPoint(x: 0, y: 100))
bezierPath.addLine(to: CGPoint(x: 300, y: 100))
//bezierPath.addLine(to: CGPoint(x: 180, y: 120))


let path = bezierPath.cgPath
    
UIBezierPath(ovalIn: CGRect(x: 20  , y: view.bounds.size.height/2 - refreshRadius, width: 2*refreshRadius, height: 2*refreshRadius)).cgPath
let layer = CAShapeLayer()
layer.path = path
layer.strokeColor = UIColor.white.cgColor
layer.fillColor = UIColor.clear.cgColor
layer.lineWidth = 4.0
layer.lineDashPattern = [2, 3]
view.layer.addSublayer(layer)

let path2 = UIBezierPath(ovalIn: CGRect(x: 3 * refreshRadius , y: view.bounds.size.height/2 - refreshRadius, width: 2*refreshRadius, height: 2*refreshRadius)).cgPath
let layer2 = CAShapeLayer()
layer2.path = path2
layer2.strokeColor = UIColor.white.cgColor
layer2.fillColor = UIColor.clear.cgColor
layer2.lineWidth = 4.0
layer2.lineDashPattern = [2, 3]
//view.layer.addSublayer(layer2)

let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
strokeStartAnimation.fromValue = 1
strokeStartAnimation.toValue = 0
strokeStartAnimation.duration = 5
strokeStartAnimation.repeatCount = 100
layer.add(strokeStartAnimation, forKey: nil)


//let strokeStartAnimation2 = CABasicAnimation(keyPath: "strokeEnd")
//strokeStartAnimation2.toValue = 0
//strokeStartAnimation2.fromValue = 1
//strokeStartAnimation2.duration = 1.5
//strokeStartAnimation2.repeatCount = 100
//layer2.add(strokeStartAnimation2, forKey: nil)

//view.addSubview(imageView)
PlaygroundPage.current.liveView = view



