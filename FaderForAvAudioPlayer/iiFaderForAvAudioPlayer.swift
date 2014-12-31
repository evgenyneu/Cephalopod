//
//  iiSoundPlayerFadeOut.swift
//  iiFaderForAvAudioPlayer
//
//  Created by Evgenii Neumerzhitckii on 31/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation
import AVFoundation

let iiFaderForAvAudioPlayer_defaultFadeIntervalSeconds = 2.0
let iiFaderForAvAudioPlayer_defaultVelocity = 8.0

@objc
public class iiFaderForAvAudioPlayer {
  let player: AVAudioPlayer
  private var timer: NSTimer?

  private let stepsPerSecond = 20.0 // The higher the number - the higher the quality of fade
  private var fadeIntervalSeconds = iiFaderForAvAudioPlayer_defaultFadeIntervalSeconds

  private var startVolume = 0.0
  private var currentStep = 0

  init(player: AVAudioPlayer) {
    self.player = player
  }

  deinit {
    println("iiFaderForAvAudioPlayer deinit")
    stop()
  }

  func fadeOut(fadeIntervalSeconds: Double = iiFaderForAvAudioPlayer_defaultFadeIntervalSeconds) {
    self.fadeIntervalSeconds = fadeIntervalSeconds
    startTimer()
  }

  // Stop fading. Does not stop the sound.
  func stop() {
    stopTimer()
  }

  private func startTimer() {
    stopTimer()
    startVolume = Double(player.volume)
    if startVolume <= 0 { return }
    currentStep = 0

    timer = NSTimer.scheduledTimerWithTimeInterval(1 / stepsPerSecond, target: self,
      selector: "timerFired:", userInfo: nil, repeats: true)
  }

  private func stopTimer() {
    if let currentTimer = timer {
      currentTimer.invalidate()
      timer = nil
    }
  }

  func timerFired(timer: NSTimer) {
    if shouldStopTimer {
      player.volume = 0
      stopTimer()
      return
    }

    let currentTimeFrom0To1 = iiFaderForAvAudioPlayer.timeFrom0To1(
      currentStep, fadeIntervalSeconds: fadeIntervalSeconds, stepsPerSecond: stepsPerSecond)

    let currentVolumeMultiplier = iiFaderForAvAudioPlayer.volumeMultiplier(
      currentTimeFrom0To1, velocity: iiFaderForAvAudioPlayer_defaultVelocity)

    var newVolume = startVolume * currentVolumeMultiplier

    player.volume = Float(newVolume)

    currentStep++
  }

  var shouldStopTimer: Bool {
    let totalSteps = fadeIntervalSeconds * stepsPerSecond
    return Double(currentStep) > totalSteps
  }

  public class func timeFrom0To1(currentStep: Int, fadeIntervalSeconds: Double,
    stepsPerSecond: Double) -> Double {

    let totalSteps = fadeIntervalSeconds * stepsPerSecond
    var result = Double(currentStep) / totalSteps

    if result < 0 { result = 0 }
    if result > 1 { result = 1 }

    return result
  }

  public class func volumeMultiplier(timeFrom0To1: Double, velocity: Double) -> Double {
    var time = timeFrom0To1
    if time < 0 { time = 0 }
    if time > 1 { time = 1 }
    return pow(M_E, -time * velocity)
  }
}
