//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let softTime = 5
    let mediumTime = 8
    let hardTime = 12
    let eggTimes = ["Soft":3,"Medium":4,"Hard":7]
    var player: AVAudioPlayer?
    var secondsRemaining = 60
    var totalSeconds = 0
    
    @IBOutlet weak var titleLabel: UILabel!
    var timer = Timer()
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        progressBar.progress = 0.0
        timer.invalidate()
        let hardness = sender.currentTitle!
        secondsRemaining = eggTimes[hardness]!
        totalSeconds = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        
        if secondsRemaining>0 {
            print("\(secondsRemaining) seconds.")
            secondsRemaining -= 1
            progressBar.progress = Float(totalSeconds-secondsRemaining)/Float(totalSeconds)
        }
        else{
            timer.invalidate()
            titleLabel.text = "Done"
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player?.play()
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                DispatchQueue.main.async {
                    self.titleLabel.text = "How do you like your eggs?"
                }
                
            }
        }
    }
}
