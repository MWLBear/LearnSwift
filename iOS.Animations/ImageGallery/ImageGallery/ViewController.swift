
import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    let images = [
        ImageViewCard(imageNamed: "Hurricane_Katia.jpg", title: "Hurricane Katia"),
        ImageViewCard(imageNamed: "Hurricane_Douglas.jpg", title: "Hurricane Douglas"),
        ImageViewCard(imageNamed: "Hurricane_Norbert.jpg", title: "Hurricane Norbert"),
        ImageViewCard(imageNamed: "Hurricane_Irene.jpg", title: "Hurricane Irene")
    ]
    var isGalleryOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "info", style: .done, target: self, action: #selector(info))
    }
    
    @objc func info() {
        let alertController = UIAlertController(title: "Info", message: "Public Domain images by NASA", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for image in images {
            image.didSelect = selectImage
            image.layer.anchorPoint.y = 0.0
            image.frame = view.bounds
            view.addSubview(image)
        }
        navigationItem.title = images.last?.title
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0/250
        view.layer.sublayerTransform = perspective
        
    }
    
    @IBAction func toggleGallery(_ sender: AnyObject) {
        
        if isGalleryOpen {
            for subView in view.subviews {
                guard let image = subView as? ImageViewCard else {
                    continue
                }
                let animations = CABasicAnimation(keyPath: "transform")
                animations.fromValue = NSValue(caTransform3D: image.layer.transform)
                animations.toValue = NSValue(caTransform3D: CATransform3DIdentity)
                animations.duration = 0.33
                image.layer.add(animations, forKey: nil)
                image.layer.transform = CATransform3DIdentity
            }
            isGalleryOpen = false
            return
        }
        
        var imageYOffset: CGFloat = 50.0
        for subview in view.subviews {
            guard let image = subview as? ImageViewCard else {
                continue
            }
            var imageTransform = CATransform3DIdentity
            imageTransform = CATransform3DTranslate(imageTransform, 0.0, imageYOffset, 0.0)
            imageTransform = CATransform3DScale(imageTransform, 0.95, 0.6, 1.0)
            imageTransform = CATransform3DRotate(imageTransform, .pi/8, -1.0, 0.0, 0.0)
            
            let animations = CABasicAnimation(keyPath: "transform")
            animations.fromValue = NSValue(caTransform3D: image.layer.transform)
            animations.toValue = NSValue(caTransform3D: imageTransform)
            animations.duration = 0.3
            image.layer.add(animations, forKey: nil)
            image.layer.transform = imageTransform
            imageYOffset += view.frame.height / CGFloat(images.count)
            
        }
        isGalleryOpen = true
        
    }
    
    func selectImage(selectIamge: ImageViewCard) {
        for subview in view.subviews {
            guard let image = subview as? ImageViewCard else {
                continue
            }
            if image == selectIamge {
                UIView.animate(withDuration: 0.33, delay: 0.0, options: .curveEaseIn) {
                    image.layer.transform = CATransform3DIdentity
                } completion: { _ in
                    self.view.bringSubviewToFront(image)
                }
            }else {
                UIView.animate(withDuration: 0.33, delay: 0.0, options: .curveEaseIn) {
                    image.alpha = 0.0
                } completion: { _ in
                    image.alpha = 1.0
                    image.layer.transform = CATransform3DIdentity
                }

            }
        }
        self.navigationItem.title = selectIamge.title
        isGalleryOpen = false
    }
}
