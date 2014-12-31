//
//  ViewController.swift
//  FaderForAvAudioPlayer
//
//  Created by Evgenii Neumerzhitckii on 31/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import AVFoundation

private let audioFileName = "i_ll_be_waiting_carlos_vallejo.mp3"

class ViewController: UIViewController {
  private var player: AVAudioPlayer?
  private var fader: iiFaderForAvAudioPlayer?
  @IBOutlet weak var sliderParentView: UIView!
  @IBOutlet weak var fadingLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    sliderParentView.backgroundColor = nil
    createControls()
    playSound(audioFileName)
    player?.volume = 0

    if let currentPlayer = player {
      fadeIn(currentPlayer)
    }
  }

  private func createControls() {
    SliderControls.create(AppDelegate.current.controls.allArray,
      delegate: nil, superview: sliderParentView)
  }

  @IBAction func onFadeInTapped(sender: AnyObject) {
    fadingLabel.hidden = false

    if let currentPlayer = player {
      fadeIn(currentPlayer)
    }
  }

  @IBAction func onFadeOutTapped(sender: AnyObject) {
    fadingLabel.hidden = false

    if let currentPlayer = player {
      fadeOut(currentPlayer)
    }
  }

  private func fadeIn(aPlayer: AVAudioPlayer) {
    fader =  ViewController.initFader(aPlayer, fader: fader)
    let currentVolume = Double(aPlayer.volume)
    fader?.fade(fromVolume: currentVolume, toVolume: 1,
      interval: AppDelegate.current.controls.value(ControlType.interval),
      velocity: AppDelegate.current.controls.value(ControlType.velocity)) { finished in

      if finished {
        self.fadingLabel.hidden = true
      }
    }
  }

  private func fadeOut(aPlayer: AVAudioPlayer) {
    fader = ViewController.initFader(aPlayer, fader: fader)
    let currentVolume = Double(aPlayer.volume)

    fader?.fade(fromVolume: currentVolume, toVolume: 0,
      interval: AppDelegate.current.controls.value(ControlType.interval),
      velocity: AppDelegate.current.controls.value(ControlType.velocity)) { finished in

      if finished {
        self.fadingLabel.hidden = true
      }
    }
  }

  private func playSound(fileName: String) {
    let error: NSErrorPointer = nil
    let soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), fileName as NSString, nil, nil)
    let newPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: error)
    newPlayer.numberOfLoops = -1

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

