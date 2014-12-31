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

  override func viewDidLoad() {
    super.viewDidLoad()

    sliderParentView.backgroundColor = nil
    createControls()
    playSound(audioFileName)
    player?.volume = 0
    fadeIn()
  }

  private func createControls() {
    SliderControls.create(AppDelegate.current.controls.allArray,
      delegate: nil, superview: sliderParentView)
  }

  @IBAction func onFadeInTapped(sender: AnyObject) {
    fadeIn()
  }

  @IBAction func onFadeOutTapped(sender: AnyObject) {
    fadeOut()
  }

  private func fadeIn() {
    if let currentPlayer = player {
      fader =  ViewController.initFader(currentPlayer, fader: fader)
      let currentVolume = Double(currentPlayer.volume)
      fader?.fade(fromVolume: currentVolume, toVolume: 1,
        interval: AppDelegate.current.controls.value(ControlType.interval),
        velocity: AppDelegate.current.controls.value(ControlType.velocity))
    }
  }

  private func fadeOut() {
    if let currentPlayer = player {
      fader = ViewController.initFader(currentPlayer, fader: fader)
      let currentVolume = Double(currentPlayer.volume)

      fader?.fade(fromVolume: currentVolume, toVolume: 0,
        interval: AppDelegate.current.controls.value(ControlType.interval),
        velocity: AppDelegate.current.controls.value(ControlType.velocity))
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

