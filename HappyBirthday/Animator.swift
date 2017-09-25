//
//  Animator.swift
//  HappyBirthday
//
//  Created by Joss Manger on 9/25/17.
//  Copyright © 2017 Lookforrachel. All rights reserved.
//

import UIKit

class FadeAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        
        let toView = toVC?.view
        let fromView = fromVC?.view
        toView?.layer.opacity=0
        container.addSubview(toView!)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            toView?.layer.opacity = 1
        }, completion: {
            completed in
            let success = !transitionContext.transitionWasCancelled
            
            if(success){
                fromView!.removeFromSuperview()
                transitionContext.completeTransition(success)
            }
            
        })
        
    }
    
}
