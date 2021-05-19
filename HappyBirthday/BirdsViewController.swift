//
//  BirdsViewController.swift
//  HappyBirthday
//
//  Created by Joss Manger on 5/14/21.
//  Copyright © 2021 Lookforrachel. All rights reserved.
//

import UIKit
import AVFoundation

class BirdsViewController: ViewController {
  
  private var swipeInteractor = InteractiveTopDownFadeTransition()
  
  
  
  override func viewDidLoad() {
    audioPath = Constants.birds
    super.viewDidLoad()
    
  }
  
  override func awakeFromNib() {
    //swipeInteractor = InteractiveTopDownFadeTransition()
    
    swipeInteractor.wireToViewController(viewController: self)
  }
  
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    print("prepareing for segue in kitch")
    segue.destination.transitioningDelegate = self
  }
  
  override func beginArrowAnimation(){
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
    super.viewDidAppear(animated)
  }
  
  
}


