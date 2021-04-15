//
//  SlideOutAnimationController.swift
//  StoreSearch
//
//  Created by admin on 2021/4/13.
//

import UIKit
class SlideOutAnimationController:NSObject,UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) {
            // from is visible at the beginning of the transition, or at the end of a canceled transition
            let containerView = transitionContext.containerView
            let time = transitionDuration(using: transitionContext)
           
            UIView.animate(withDuration: time) {
                fromView.center.y -= containerView.bounds.size.height
                fromView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            } completion: { finished in
                transitionContext.completeTransition(finished)
            }
        }
    }
}
