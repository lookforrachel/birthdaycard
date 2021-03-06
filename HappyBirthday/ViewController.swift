//
//  ViewController.swift
//  HappyBirthday
//
//  Created by Rachel Yee on 9/24/17.
//  Copyright © 2017 Lookforrachel. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  @IBOutlet weak var arrow: UIImageView!
  
  @IBAction func toNeonBtn(_ sender: Any) {
    audioPlayer?.stop()
  }
  
  open var audioPath: AudioPath? = nil
  
  weak var audioPlayer: AVAudioPlayer?
  
  internal var swipeInteractor = InteractiveTopDownFadeTransition()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view, typically from a nib.
    self.transitioningDelegate = self
    
  }
  
  override func awakeFromNib() {

    swipeInteractor.wireToViewController(viewController: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    print("prepareing for segue in kitch")
    segue.destination.transitioningDelegate = self
  }
  
  func beginArrowAnimation(){
    UIView.animateKeyframes(withDuration: 1.0, delay: 0.0, options: [.autoreverse,.repeat], animations: {
      
      UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0, animations: {
        self.arrow?.layer.frame.origin.x+=10.0
      })
      
    }, completion: nil)
  }
  
  override func viewDidLayoutSubviews() {
    
    if self is BirdsViewController {
      let image = arrow?.image?.withRenderingMode(.alwaysTemplate)
      arrow?.image = image
      arrow?.tintColor = UIColor.init(red: 236/255, green: 0/255, blue: 140/255, alpha: 1.0)
      
    }
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    if self is BirdsViewController {
      beginArrowAnimation()
    }
    do{
      if let audioPath = self.audioPath, let url = audioPath.url {
        AppDelegate.player = try AVAudioPlayer(contentsOf: url)
        audioPlayer = AppDelegate.player
        audioPlayer?.play()
      }
    }
    
    catch{
      print(error)
    }
    
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    audioPlayer?.stop()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

extension ViewController: UIViewControllerTransitioningDelegate {
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return Transitions.fade.initialiseTranstion()
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return Transitions.fade.initialiseTranstion()
  }
  
  func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    print("so this presentation method was called - CK \(animator) \(swipeInteractor)")
    return swipeInteractor.interactionInProgress ? swipeInteractor : nil
  }
  
}
