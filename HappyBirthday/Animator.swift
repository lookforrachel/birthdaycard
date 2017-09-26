//
//  Animator.swift
//  HappyBirthday
//
//  Created by Joss Manger on 9/25/17.
//  Copyright © 2017 Lookforrachel. All rights reserved.
//

import UIKit

enum Transitions {
    case fade
    case instant
    
    func initialiseTranstion()->UIViewControllerAnimatedTransitioning{
        switch self{
        case .fade:
            return FadeAnimator()
        case .instant:
            return InstantTransition()
        }
        
        
    }
    
}

class InstantTransition:FadeAnimator{
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.0
    }
    
}

class FadeAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning {
    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        print("started")
    }
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let container = transitionContext.containerView
//        let fromVC = transitionContext.viewController(forKey: .from)
//        let toVC = transitionContext.viewController(forKey: .to)
//
//        let toView = toVC?.view
//        let fromView = fromVC?.view
//        toView?.layer.opacity=0
//        fromView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0);
//        container.addSubview(toView!)
//
//        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
//            toView?.layer.opacity = 1
//            fromView?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1);
//        }, completion: {
//            completed in
//            let success = !transitionContext.transitionWasCancelled
//
//            if(success){
//                fromView?.transform = CGAffineTransform.identity
//                fromView!.removeFromSuperview()
//                transitionContext.completeTransition(success)
//            } else {
//                print("and something went a bit wrong")
//            }
//
//        })
//
//    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let inView   = transitionContext.containerView
        let toView   = transitionContext.view(forKey: .to)!
        let fromView = transitionContext.view(forKey: .from)!
        
        var frame = inView.bounds
        
            frame.origin.y = -frame.size.height
            toView.frame = frame
            
            inView.addSubview(toView)
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toView.frame = inView.bounds
            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })

        }
    
    
    
}

class InteractiveTopDownFadeTransition: UIPercentDrivenInteractiveTransition {
    var interactionInProgress = false
    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!
    
    func wireToViewController(viewController: UIViewController!) {
        self.viewController = viewController
        prepareGestureRecognizerInView(view: viewController.view)
    }
    
    private func prepareGestureRecognizerInView(view: UIView) {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture))
        gesture.edges = UIRectEdge.left
        view.addGestureRecognizer(gesture)
    }

//    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
//        super.startInteractiveTransition(transitionContext)
//
//    }
    
    func handleGesture(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        
        // 1
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        var progress = (translation.x / viewController.view.frame.width)
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        print("gesture", gestureRecognizer.state.rawValue,translation,progress, interactionInProgress)
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        
        let useSegue = false;
        
        var segue = ""
        var vc = ""
        if viewController is ViewController{
            segue = "neon-segue"
            vc = "neonVC"
        } else if viewController is NeonViewController{
            segue="kitch-segue"
            vc = "kitchVC"
        }
        
        
        let target = storyboard.instantiateViewController(withIdentifier: vc) as UIViewController
        
        guard let delegate = viewController as? UIViewControllerTransitioningDelegate else {
            fatalError()
        }
        
        
        print(segue)
        switch gestureRecognizer.state {
            
        case .began:
            // 2
            interactionInProgress = true
            
            if(useSegue){
                viewController.performSegue(withIdentifier: segue, sender: self)
            } else {
                print("began", delegate)
                target.transitioningDelegate = delegate
                viewController.present(target, animated: true, completion: nil)
            }

        case .changed:
            // 3
            print("changed, should complete \((progress > 0.5))")
            shouldCompleteTransition = progress > 0.5
            update(progress)
            
        case .cancelled:
            // 4
            print("cancelled")
            interactionInProgress = false
            cancel()
            
        case .ended:
            // 5
            interactionInProgress = false
            
            if !shouldCompleteTransition {
                print("ended Cancelled",interactionInProgress)
                cancel()
            } else {
                print("finished", interactionInProgress)
                finish()
            }
            
        default:
            print("Unsupported")
        }
    }
    
}

//class InteractiveTopDownFade: NSObject, UIViewControllerInteractiveTransitioning{
//    
//    var wantsInteractiveStart: Bool = true
//    
//    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
//        <#code#>
//    }
//    
//}

