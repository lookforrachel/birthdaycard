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
  
  override func viewDidLoad() {
    audioPath = Constants.party
    print("vdl on neon")
    super.viewDidLoad()

  }
  
}
