import UIKit
import PlaygroundSupport

let size = CGSize(width: 300 , height: 200)
let frame = CGRect(origin: .zero, size: size)
let view = UIView(frame: frame)
view.backgroundColor = .red

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

view.addSubview(imageView)
PlaygroundPage.current.liveView = view
