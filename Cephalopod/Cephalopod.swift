import Foundation
import AVFoundation

/**
 
A sound fader for AvAudioPlayer written in Swift - iOS, tvOS and macOS.
 
Usage
--------
 
   import AVFoundation
   import Cephalopod // For CocoaPods and Carthage
   // ---
   
   var playerInstance: AVAudioPlayer?
   var cephalopod: Cephalopod?
   
   override func viewDidLoad() {
     super.viewDidLoad()
     
     // Create player instance
     guard let path = Bundle.main.path(forResource: "squid", ofType: "mp3") else { return }
     guard let player = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path)) else { return }
     playerInstance = player
     
     // Start audio playback
     player.play()
     player.volume = 0
     
     // Fade in the sound
     cephalopod = Cephalopod(player: player)
     cephalopod?.fadeIn()
   }
   
*/
open class Cephalopod: NSObject {
  /**
   
  Changes the quality of the fade effect. The higher number means the higher the quality of fade. Higher values consume more CPU resources. Default: 30.
   
  */
  open var volumeAlterationsPerSecond = 30.0
  
  /// Default duration of the fade effect
  public static let defaultFadeDurationSeconds = 3.0
    
  /// Default velocity of the fade effect
  public static let defaultVelocity = 2.0

  let player: AVAudioPlayer
  var timer: AutoCancellingTimer?
  
  
  
  private var fadeDurationSeconds = defaultFadeDurationSeconds
  private var fadeVelocity = defaultVelocity
  
  private var fromVolume = 0.0
  private var toVolume = 0.0
  
  private var currentStep = 0
  
  private var onFinished: ((Bool)->())? = nil
  
  
  /**
   
  Instantiate a cephalopod fader object.
   
  - parameter player: an instance of AVAudioPlayer.
   
  */
  public init(player: AVAudioPlayer) {
    self.player = player
  }
  
  deinit {
    callOnFinished(finished: false)
    stop()
  }
  
  /**
   
  Fade in the sound by gradually increasing the volume.
   
  - parameter duration: duration of the fade, in seconds. Default duration: 3 seconds.
   
  - parameter velocity: a number specifying how fast the sound volume is changing. Velocity of 0 creates a linear fade. Values greater than zero produce more exponential fade affect. Exponential fade sounds more gradual to a human ear. The fade sounds most natural with velocity parameter from 2 to 5. Default value: 2.
   
  - parameter onFinished: an optional closure that will be called after the fade has ended. The closure will be passed a boolean parameter `finished` indicating whether the fading has reached its end value (true) or if the fading has been cancelled (false).
   
  */
  open func fadeIn(duration: Double = defaultFadeDurationSeconds,
                   velocity: Double = defaultVelocity, onFinished: ((Bool)->())? = nil) {
    
    fade(
      fromVolume: Double(player.volume), toVolume: 1,
      duration: duration, velocity: velocity, onFinished: onFinished)
  }
  
  /**
   
  Fade out the sound by gradually decreasing the volume.
   
  - parameter duration: duration of the fade, in seconds. Default duration: 3 seconds.
   
  - parameter velocity: a number specifying how fast the sound volume is changing. Velocity of 0 creates a linear fade. Values greater than zero produce more exponential fade affect. Exponential fade sounds more gradual to a human ear. The fade sounds most natural with velocity parameter from 2 to 5. Default value: 2.
   
  - parameter onFinished: an optional closure that will be called after the fade has ended. The closure will be passed a boolean parameter `finished` indicating whether the fading has reached its end value (true) or if the fading has been cancelled (false).
   
  */
  open func fadeOut(duration: Double = defaultFadeDurationSeconds,
                    velocity: Double = defaultVelocity, onFinished: ((Bool)->())? = nil) {
    
    fade(
      fromVolume: Double(player.volume), toVolume: 0,
      duration: duration, velocity: velocity, onFinished: onFinished)
  }
  
  /**
   
  Gradually change the volume of the sound.
   
  - parameter fromVolume: the starting volume, a value from 0 to 1.
   
  - parameter toVolume: the end volume that will be reached at the end of the fade, a value from 0 to 1.
   
  - parameter duration: duration of the fade, in seconds. Default duration: 3 seconds.
   
  - parameter velocity: a number specifying how fast the sound volume is changing. Velocity of 0 creates a linear fade. Values greater than zero produce more exponential fade affect. Exponential fade sounds more gradual to a human ear. Default value: 2. The fade sounds most natural with velocity parameter from 2 to 5.
   
  - parameter onFinished: an optional closure that will be called after the fade has ended. The closure will be passed a boolean parameter `finished` indicating whether the fading has reached its end value (true) or if the fading has been cancelled (false).
   
  */
  open func fade(fromVolume: Double, toVolume: Double,
                 duration: Double = defaultFadeDurationSeconds,
                 velocity: Double = defaultVelocity, onFinished: ((Bool)->())? = nil) {
    
    self.fromVolume = Cephalopod.makeSureValueIsBetween0and1(value: fromVolume)
    self.toVolume = Cephalopod.makeSureValueIsBetween0and1(value: toVolume)
    self.fadeDurationSeconds = duration
    self.fadeVelocity = velocity
    
    callOnFinished(finished: false)
    self.onFinished = onFinished
    
    player.volume = Float(self.fromVolume)
    
    if self.fromVolume == self.toVolume {
      callOnFinished(finished: true)
      return
    }
    
    startTimer()
  }
  
  /// Stop changing the volume. It does not stop the playback.
  open func stop() {
    callOnFinished(finished: false)
    stopTimer()
  }
  
  private var fadeIn: Bool {
    return fromVolume < toVolume
  }
  
  private func callOnFinished(finished: Bool) {
    let saveOnFinished: ((Bool)->())? = onFinished
    onFinished = nil // Make sure it is called only once
    saveOnFinished?(finished)
  }
  
  private func startTimer() {
    stopTimer()
    currentStep = 0
    
    let delay =  1 / volumeAlterationsPerSecond
    
    timer = AutoCancellingTimer(interval: delay, repeats: true) { [weak self] in
      self?.timerFired();
    }
  }
  
  private func stopTimer() {
    if let currentTimer = timer {
      currentTimer.cancel()
      timer = nil
    }
  }
  
  func timerFired() {
    if shouldStopTimer {
      player.volume = Float(toVolume)
      stopTimer()
      callOnFinished(finished: true)
      return
    }
    
    let currentTimeFrom0To1 = Cephalopod.timeFrom0To1(
      currentStep: currentStep, fadeDurationSeconds: fadeDurationSeconds, volumeAlterationsPerSecond: volumeAlterationsPerSecond)
    
    var volumeMultiplier: Double
    
    var newVolume: Double = 0
    
    if fadeIn {
      volumeMultiplier = Cephalopod.fadeInVolumeMultiplier(timeFrom0To1: currentTimeFrom0To1,
                                                      velocity: fadeVelocity)
      
      newVolume = fromVolume + (toVolume - fromVolume) * volumeMultiplier
      
    } else {
      volumeMultiplier = Cephalopod.fadeOutVolumeMultiplier(timeFrom0To1: currentTimeFrom0To1,
                                                       velocity: fadeVelocity)
      
      newVolume = toVolume - (toVolume - fromVolume) * volumeMultiplier
    }
    
    player.volume = Float(newVolume)
    
    currentStep += 1
  }
  
  var shouldStopTimer: Bool {
    let totalSteps = fadeDurationSeconds * volumeAlterationsPerSecond
    return Double(currentStep) > totalSteps
  }
  
  class func timeFrom0To1(currentStep: Int, fadeDurationSeconds: Double,
                          volumeAlterationsPerSecond: Double) -> Double {
    
    let totalSteps = fadeDurationSeconds * volumeAlterationsPerSecond
    var result = Double(currentStep) / totalSteps
    
    result = makeSureValueIsBetween0and1(value: result)
    
    return result
  }
  
  // Graph: https://www.desmos.com/calculator/wnstesdf0h
  class func fadeOutVolumeMultiplier(timeFrom0To1: Double, velocity: Double) -> Double {
    let time = makeSureValueIsBetween0and1(value: timeFrom0To1)
    return pow(M_E, -velocity * time) * (1 - time)
  }
  
  class func fadeInVolumeMultiplier(timeFrom0To1: Double, velocity: Double) -> Double {
    let time = makeSureValueIsBetween0and1(value: timeFrom0To1)
    return pow(M_E, velocity * (time - 1)) * time
  }
  
  private class func makeSureValueIsBetween0and1(value: Double) -> Double {
    if value < 0 { return 0 }
    if value > 1 { return 1 }
    return value
  }
}
