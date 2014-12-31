//
//  ViewController.swift
//  FaderForAvAudioPlayer
//
//  Created by Evgenii Neumerzhitckii on 31/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import AVFoundation

private let audioFileName = "weather_alert_sound_bible.mp3"

class ViewController: UIViewController {
  private var player: AVAudioPlayer?
  private var fader: iiFaderForAvAudioPlayer?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  @IBAction func onPlayTapped(sender: AnyObject) {
    playSound(audioFileName)
  }

  private func playSound(fileName: String) {
    let error: NSErrorPointer = nil
    let soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), fileName as NSString, nil, nil)
    let newPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: error)

    if let currentPlayer = player {
      currentPlayer.stop()
    }

    player = newPlayer
    newPlayer.play()

    if let currentFader = fader {
      currentFader.stop()
    }

    fader = iiFaderForAvAudioPlayer(player: newPlayer)
    fader?.fadeOut(fadeIntervalSeconds: 2)
  }
}

