//
//  PopAnimator.swift
//  BeginnerCook
//
//  Created by admin on 2021/5/19.
//  Copyright © 2021 Razeware LLC. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning{
    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero
    var dismissCompletion: (()->Void)?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let contanierView = transitionContext.containerView
        let herbView = presenting ? transitionContext.view(forKey: .to)! : transitionContext.view(forKey: .from)!
        
        let initialFrame = presenting ? originFrame : herbView.frame
        let finalFrame = presenting ? herbView.frame : originFrame
       
        let xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        
        let scaleTransfrom = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting {
            herbView.transform = scaleTransfrom
            herbView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midX)
            herbView.clipsToBounds = true
        }
        
        if let toView = transitionContext.view(forKey: .to) {
            contanierView.addSubview(toView)
        }
        contanierView.bringSubviewToFront(herbView)
        
        let viewController = (presenting ? transitionContext.viewController(forKey: .to) : transitionContext.viewController(forKey: .from)) as! HerbDetailsViewController
        
        if presenting {
            viewController.containerView.alpha = 0.0
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0) {
            herbView.transform = self.presenting ? CGAffineTransform.identity : scaleTransfrom
            herbView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            viewController.containerView.alpha = self.presenting ? 1.0 : 0.0
            herbView.layer.cornerRadius = self.presenting ? 0 : 20.0 / xScaleFactor
        } completion: { _ in
            if !self.presenting {
                self.dismissCompletion?()
            }
            transitionContext.completeTransition(true)
        }

     
        
        
        
    }
}
