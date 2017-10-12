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

class FadeAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning, CAAnimationDelegate {
    
    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        print("started")
    }
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let container = transitionContext.containerView
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)

        let toView = toVC?.view
        let fromView = fromVC?.view

        toView?.layer.opacity = 0
        //toView?.layer.bounds.origin.x = 10
        let startframe = CGRect(x: 0, y: 0, width: container.frame.width, height: container.frame.height)
        //let endframe = CGRect(x: 0, y: 0, width: container.frame.width, height: container.frame.height)
        toView!.layer.frame = startframe
        container.addSubview(toView!)
        print(startframe)
        //toView?.transform = CGAffineTransform.

        let debug = UserDefaults.standard.bool(forKey: "debug")
        var debugview:UIView?
        if (debug){
            debugview = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
            debugview!.backgroundColor = UIColor.red
            container.addSubview(debugview!)
        }



        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            toView!.layer.opacity = 1
            //toView!.frame = endframe
            //toView?.transform = CGAffineTransform.identity
            if let dview = debugview {
            dview.frame = CGRect(x: 0, y: 0, width: 10, height: container.frame.height)
            dview.backgroundColor = UIColor.green
            }
        }, completion: { completed in
            let success = !transitionContext.transitionWasCancelled
            print("success:  \(success)")
            print(toView!.frame)
            transitionContext.completeTransition(success)
            if let dview = debugview {
            dview.removeFromSuperview()
            }
            if(success){
                //fromView?.transform = CGAffineTransform.identity
                fromView!.removeFromSuperview()
            } else {
                print("and something went a bit wrong")
            }

        })

    }
    
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        print("will attempt animation")
//        let container = transitionContext.containerView
//        let fromVC = transitionContext.viewController(forKey: .from)
//        let toVC = transitionContext.viewController(forKey: .to)
//
//        let toView = toVC?.view
//        let fromView = fromVC?.view
//
//        //toView?.layer.opacity = 0
//        //toView?.layer.bounds.origin.x = 10
//        let startframe = CGRect(x: 0, y: 0, width: container.frame.width, height: 0)
//        let endframe = CGRect(x: 0, y: 0, width: container.frame.width, height: container.frame.height)
//
//        let maskLayer = CAShapeLayer()
//        maskLayer.path =  UIBezierPath(rect: startframe).cgPath
//        //maskLayer.fillColor = UIColor.black.cgColor
//
//        toView?.layer.mask = maskLayer
//        container.addSubview(toView!)
//
////        let debugview = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
////        debugview.backgroundColor = UIColor.red
////        container.addSubview(debugview)
//
//        let startPath = maskLayer.path!
//        let endPath = UIBezierPath(rect: endframe)
//
//        let anim = CABasicAnimation(keyPath: "path")
//        anim.fromValue = startPath
//        anim.toValue = endPath
//        print(startPath,endPath)
//        anim.duration = self.transitionDuration(using: transitionContext)
//        anim.delegate = self
//        maskLayer.add(anim, forKey: "path")
//
//        let oanimation = CABasicAnimation(keyPath: "opacity")
//        oanimation.fromValue = 0.0
//        oanimation.toValue = 1.0
//        oanimation.duration = self.transitionDuration(using: transitionContext)
//        maskLayer.add(oanimation, forKey: "opacity")
//
////        let moreanim = CABasicAnimation(keyPath: "frame.height")
////        moreanim.fromValue = debugview.frame
////        moreanim.toValue = CGRect(x: 0, y: 0, width: 10, height: container.frame.height)
////        anim.duration = self.transitionDuration(using: transitionContext)
////        debugview.layer.add(moreanim, forKey: "frame.height")
//
//        CATransaction.begin()
//
//        CATransaction.setCompletionBlock({
//            print("complete basic animations")
//            toView?.removeFromSuperview()
//            fromView?.removeFromSuperview()
//            maskLayer.path = endPath.cgPath
//            transitionContext.completeTransition(true)
//        })
//        CATransaction.commit()
//
//
//
//    }

    func animateLayer(layer:CALayer,animation:CABasicAnimation,_ block:(()->Void)? = nil){
        animation.setValue(block, forKey: "block")
        layer.add(animation, forKey: "path")
        
        //block?()
    }
    
    
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let inView   = transitionContext.containerView
//        let toView   = transitionContext.view(forKey: .to)!
//        let fromView = transitionContext.view(forKey: .from)!
//
//        var frame = inView.bounds
//
//            frame.origin.y = -frame.size.height
//            toView.frame = frame
//
//            inView.addSubview(toView)
//            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
//                toView.frame = inView.bounds
//            }, completion: { finished in
//                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//            })
//
//        }
    
    
    
}

class InteractiveTopDownFadeTransition: UIPercentDrivenInteractiveTransition {
    var interactionInProgress = false
    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!
    private var useSegue = false;
    override init() {
        super.init()
        useSegue = UserDefaults.standard.bool(forKey: "useSegue")
    }
    
    func wireToViewController(viewController: UIViewController!) {
        self.viewController = viewController
        prepareGestureRecognizerInView(view: viewController.view)
    }
    
    private func prepareGestureRecognizerInView(view: UIView) {
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture))
        
        view.addGestureRecognizer(gesture)
    }

//    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
//        super.startInteractiveTransition(transitionContext)
//
//    }
    
    func handleGesture(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        
        // 1
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        var progress = (translation.y / (viewController.view.frame.height/2))
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        //print("gesture", gestureRecognizer.state.rawValue,translation,progress, interactionInProgress)
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        
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
        
        
        //print(segue,useSegue)
        switch gestureRecognizer.state {
            
        case .began:
            // 2
            interactionInProgress = true
            
            if(useSegue){
                viewController.performSegue(withIdentifier: segue, sender: self)
            } else {
                //print("began", delegate)
                target.transitioningDelegate = delegate
                viewController.present(target, animated: true, completion: nil)
            }

        case .changed:
            // 3
            //print("changed, should complete \((progress > 0.5))")
            shouldCompleteTransition = progress > 0.5
            update(progress)
            
        case .cancelled:
            // 4
            //print("cancelled")
            interactionInProgress = false
            cancel()
            
        case .ended:
            // 5
            interactionInProgress = false
            
            if !shouldCompleteTransition {
                //print("ended Cancelled",interactionInProgress)
                cancel()
            } else {
                //print("finished", interactionInProgress)
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

