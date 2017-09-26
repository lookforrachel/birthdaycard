//
//  ViewController.swift
//  HappyBirthday
//
//  Created by Rachel Yee on 9/24/17.
//  Copyright © 2017 Lookforrachel. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var arrow: UIImageView!
    @IBAction func toNeonBtn(_ sender: Any) {
        audioPlayer.stop()
    }
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()

    private var swipeInteractor = InteractiveTopDownFadeTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.transitioningDelegate = self
        do{
            let audioPath = Bundle.main.path(forResource: "Birds_01", ofType: "aif")
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        }

        catch{
            print(error)
        }
        //audioPlayer.play()
        
       
        
    }

    override func awakeFromNib() {
        //swipeInteractor = InteractiveTopDownFadeTransition()
        
        swipeInteractor.wireToViewController(viewController: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepareing for segue in kitch")
        segue.destination.transitioningDelegate = self
    }
    
    func beginArrowAnimation(){
       UIView.animateKeyframes(withDuration: 1.0, delay: 0.0, options: [.autoreverse,.repeat], animations: {
        
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0, animations: {
                self.arrow.layer.frame.origin.x+=10.0
            })
        
       }, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        let image = arrow.image?.withRenderingMode(.alwaysTemplate)
        arrow.image = image
        arrow.tintColor = UIColor.init(red: 236/255, green: 0/255, blue: 140/255, alpha: 1.0)
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        beginArrowAnimation()
         //swipeInteractor.wireToViewController(viewController: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Transitions.fade.initialiseTranstion()
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Transitions.fade.initialiseTranstion()
    }
//
//    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        return swipeInteractor.interactionInProgress ? swipeInteractor : nil
//    }
    
//    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        print("so this dismissal method was called")
//        return swipeInteractor
//    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        print("so this presentation method was called - CK \(animator) \(swipeInteractor)")
        return swipeInteractor.interactionInProgress ? swipeInteractor : nil
    }
    
    
}

