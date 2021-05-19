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
  
  override func viewDidLoad() {
    audioPath = Constants.birds
    super.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    beginArrowAnimation()
  }
  
  
}


