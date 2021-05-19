//
//  NeonViewController.swift
//  HappyBirthday
//
//  Created by Rachel Yee on 9/24/17.
//  Copyright © 2017 Lookforrachel. All rights reserved.
//

import UIKit
import AVFoundation

class NeonViewController: ViewController {

    @IBAction func toKitschBtn(_ sender: Any) {
                audioPlayer?.stop()
    }
  
    private var swipeInteractor = InteractiveTopDownFadeTransition()

  override func viewDidLoad() {
    audioPath = Constants.party
    super.viewDidLoad()
    
  }
  

    override func awakeFromNib() {
        swipeInteractor = InteractiveTopDownFadeTransition()
        swipeInteractor.wireToViewController(viewController: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepareing for segue in neon")
        segue.destination.transitioningDelegate = self
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        print("so this dismissal method was called")
//        return swipeInteractor.interactionInProgress ? swipeInteractor : nil
//    }
//    
//    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        //print("so this presentation method was called -neon \(animator) \(swipeInteractor)")
//        return swipeInteractor.interactionInProgress ? swipeInteractor : nil
//    }
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return Transitions.fade.initialiseTranstion()
//    }
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return Transitions.fade.initialiseTranstion()
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
