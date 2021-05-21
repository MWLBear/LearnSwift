import UIKit

class RevealAnimator: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning, CAAnimationDelegate{
    
    let animationDuration = 2.0
    var operation: UINavigationController.Operation = .push
    weak var storedContext: UIViewControllerContextTransitioning?
    var interactive = false
    private var pausedTime: CFTimeInterval = 0
    private var isLayerBased: Bool {
        return operation == .push
    }
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        storedContext = transitionContext
        
        
        if interactive && isLayerBased {
            let transitionLayer = transitionContext.containerView.layer
            pausedTime = transitionLayer.convertTime(CACurrentMediaTime(), from: nil)
            //阻止图层运行自己的动画
            transitionLayer.speed = 0
            transitionLayer.timeOffset = pausedTime
            
        }
        
        if operation == .push {
            let fromVC = transitionContext.viewController(forKey: .from) as! MasterViewController
            let toVC = transitionContext.viewController(forKey: .to) as! DetailViewController
            transitionContext.containerView.addSubview(toVC.view)
            toVC.view.frame = transitionContext.finalFrame(for: toVC)
            
            let animation = CABasicAnimation(keyPath: "transform")
            animation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
            animation.toValue = NSValue(caTransform3D: CATransform3DConcat(CATransform3DMakeTranslation(0.0, -10.0, 0.0),      CATransform3DMakeScale(150, 150, 1.0)))
            animation.duration = animationDuration
            animation.delegate = self
            animation.fillMode = .forwards
            animation.isRemovedOnCompletion = false
            animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
           
            let maskLayer: CAShapeLayer = RWLogoLayer.logoLayer()
            maskLayer.position = fromVC.logo.position
            toVC.view.layer.mask = maskLayer
            maskLayer.add(animation, forKey: nil)
            fromVC.logo.add(animation, forKey: nil)
            
            let fade = CABasicAnimation(keyPath: "opacity")
            fade.fromValue = 0.0
            fade.toValue = 1.0
            fade.duration = animationDuration
            toVC.view.layer .add(fade, forKey: nil)
            
        }else {
            let fromView = transitionContext.view(forKey: .from)!
            let toView = transitionContext.view(forKey: .to)!
            transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
            UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveEaseIn) {
                fromView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            } completion: { _ in
                transitionContext.completeTransition(true)
            }
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let context = storedContext {
            context.completeTransition(!context.transitionWasCancelled)
            let fromVC = context.viewController(forKey: .from) as! MasterViewController
            fromVC.logo.removeAllAnimations()
            
            let toVC = context.viewController(forKey: .to) as! DetailViewController
            toVC.view.layer.mask = nil
            
        }
        storedContext = nil
    }
    
    func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: recognizer.view!.superview!)
        var progress: CGFloat = abs(translation.x / 200)
        progress = min(max(progress, 0.01), 0.99)
        switch recognizer.state {
        case .changed:
            update(progress)
        //update（）是UIPercentDrivenInteractiveTransition中的一种方法，用于设置过渡动画的当前进度。
        case .cancelled, .ended :
            interactive = false
            if progress < 0.5 {
                cancel()
            }else {
                finish()
            }
        default:
            break
        }
    }
   
    override func update(_ percentComplete: CGFloat) {
        super.update(percentComplete)
        if isLayerBased {
            let animationProgress = TimeInterval(animationDuration) * TimeInterval(percentComplete)
            storedContext?.containerView.layer.timeOffset = pausedTime + animationProgress
        }
    }
    override func cancel() {
        if isLayerBased {
            restart(forFinishing: false)
        }
        super.cancel()
    }
    override func finish() {
        if isLayerBased {
            restart(forFinishing: true)
        }
        super.finish()
    }
    private func restart(forFinishing: Bool) {
        let transitionLayer = storedContext?.containerView.layer
        transitionLayer?.beginTime = CACurrentMediaTime()
        transitionLayer?.speed = forFinishing ? 1 : -1
        
    }
}
