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

    playSound(audioFileName)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  @IBAction func onFadeOutTapped(sender: AnyObject) {
    if let currentPlayer = player {
      fader = ViewController.initFader(currentPlayer, fader: fader)
      let currentVolume = Double(currentPlayer.volume)
      fader?.fade(fromVolume: currentVolume, toVolume: 0, interval: 2, velocity: 1.5)
    }
  }

  @IBAction func onFadeInTapped(sender: AnyObject) {
    if let currentPlayer = player {
      fader =  ViewController.initFader(currentPlayer, fader: fader)
      let currentVolume = Double(currentPlayer.volume)
      fader?.fade(fromVolume: currentVolume, toVolume: 1, interval: 2, velocity: 1.5)
    }
  }

  private func playSound(fileName: String) {
    let error: NSErrorPointer = nil
    let soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), fileName as NSString, nil, nil)
    let newPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: error)
    newPlayer.numberOfLoops = -1
    newPlayer.volume = 0

    if let currentPlayer = player { return } // already playing

    player = newPlayer
    newPlayer.play()
  }

  private class func initFader(player: AVAudioPlayer, fader: iiFaderForAvAudioPlayer?)
    -> iiFaderForAvAudioPlayer {

    if let currentFader = fader {
      currentFader.stop()
    }

    return iiFaderForAvAudioPlayer(player: player)
  }
}

