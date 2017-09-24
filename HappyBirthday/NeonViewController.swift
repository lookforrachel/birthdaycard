//
//  NeonViewController.swift
//  HappyBirthday
//
//  Created by Rachel Yee on 9/24/17.
//  Copyright © 2017 Lookforrachel. All rights reserved.
//

import UIKit
import AVFoundation

class NeonViewController: UIViewController {

    @IBAction func toKitschBtn(_ sender: Any) {
                audioPlayer.stop()
    }
    
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        do{
            let audioPath = Bundle.main.path(forResource: "Who Likes to Party", ofType: "mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        }
            
        catch{
            print(error)
        }
        audioPlayer.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
