//
//  PresentTransition.swift
//  Widgets
//
//  Created by admin on 2021/5/31.
//  Copyright © 2021 Underplot ltd. All rights reserved.
//

import UIKit

class PresentTransition: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
  var auxAnimation: (()->Void)?
  var context: UIViewControllerContextTransitioning?
  var animator: UIViewPropertyAnimator?
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.75
  }
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    transtionAnimator(using: transitionContext).startAnimation()
  }
  
  func transtionAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
    let duration = transitionDuration(using: transitionContext)
    let container = transitionContext.containerView
    let to = transitionContext.view(forKey: .to)!
    container.addSubview(to)
    
    to.transform = CGAffineTransform(scaleX: 1.33, y: 1.33).concatenating(CGAffineTransform(translationX: 0.0, y: 200))
    to.alpha = 0
    
    let animator = UIViewPropertyAnimator(duration: duration, curve: .easeOut)
    animator.addAnimations({
      to.transform = CGAffineTransform(translationX: 0.0, y: 100)
    }, delayFactor: 0.15 )

    animator.addAnimations({
      to.alpha = 1.0
    }, delayFactor: 0.5)
    
    animator.addCompletion { positon in
      switch positon {
      case .end :
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      default:
        transitionContext.completeTransition(false)
      }
    }
    
    if let auxAnimation = auxAnimation {
      animator.addAnimations(auxAnimation)
    }
    
    self.animator = animator
    self.context = transitionContext
  
    animator.addCompletion { [unowned self] _ in
      self.animator = nil
      self.context = nil
    }
    animator.isUserInteractionEnabled = true
    return animator
  }
  func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
    return animator ??  transtionAnimator(using: transitionContext)
  }
  
  func interruptTransition() {
    guard let context = context else {
      return
    }
    context.pauseInteractiveTransition() //暂定动画器
    pause()//交互模式
  }
}
