import UIKit
import AVFoundation
import Cephalopod

private let audioFileName = "squid.mp3"

class ViewController: UIViewController {
  fileprivate var player: AVAudioPlayer?
  fileprivate var cephalopod: Cephalopod?
  @IBOutlet weak var sliderParentView: UIView!
  @IBOutlet weak var fadingLabel: UILabel!
  @IBOutlet weak var squidImage: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()

    sliderParentView.backgroundColor = nil
    createControls()
    playSound(audioFileName)
    player?.volume = 0
    squidImage.alpha = 0

    if let currentPlayer = player {
      fadeIn(currentPlayer)
      fadeInSquid()
    }

    UILabel.appearance().textColor = UIColor(
      red: 59/255,
      green: 69.0/255,
      blue: 103.0/255,
      alpha: 1)
    
    
    UIView.appearance().tintColor = UIColor(
      red: 82/255,
      green: 120.0/255,
      blue: 231.0/255,
      alpha: 1)
  }

  fileprivate func createControls() {
    SliderControls.create(AppDelegate.current.controls.allArray,
      delegate: nil, superview: sliderParentView)
  }

  @IBAction func onFadeInTapped(_ sender: AnyObject) {
    fadingLabel.isHidden = false
    fadingLabel.text = "Fading in..."

    if let currentPlayer = player {
      fadeIn(currentPlayer)
    }
    
    fadeInSquid()
  }

  @IBAction func onFadeOutTapped(_ sender: AnyObject) {
    fadingLabel.isHidden = false
    fadingLabel.text = "Fading out..."

    if let currentPlayer = player {
      fadeOut(currentPlayer)
    }
    
    fadeOutSquid()
  }

  fileprivate func fadeIn(_ aPlayer: AVAudioPlayer) {
    cephalopod = ViewController.initFader(aPlayer, fader: cephalopod)
    cephalopod?.fadeIn(
      duration: AppDelegate.current.controls.value(ControlType.duration),
      velocity: AppDelegate.current.controls.value(ControlType.velocity)) { finished in

      if finished {
        self.fadingLabel.isHidden = true
      }
    }
  }

  fileprivate func fadeOut(_ aPlayer: AVAudioPlayer) {
    cephalopod = ViewController.initFader(aPlayer, fader: cephalopod)

    cephalopod?.fadeOut(
      duration: AppDelegate.current.controls.value(ControlType.duration),
      velocity: AppDelegate.current.controls.value(ControlType.velocity)) { finished in

      if finished {
        self.fadingLabel.isHidden = true
      }
    }
  }

  fileprivate func playSound(_ fileName: String) {
    guard let path = Bundle.main.path(forResource: "squid", ofType: "mp3") else { return }
    guard let newPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path)) else { return }    
    newPlayer.numberOfLoops = -1

    if player != nil { return } // already playing

    player = newPlayer
    newPlayer.play()
  }

  fileprivate class func initFader(_ player: AVAudioPlayer, fader: Cephalopod?) -> Cephalopod {

    if let currentFader = fader {
      currentFader.stop()
    }

    return Cephalopod(player: player)
  }
  
  func fadeInSquid() {
    let duration = AppDelegate.current.controls.value(ControlType.duration)
   
    UIView.animate(withDuration: duration,
      delay: 0,
      options: .beginFromCurrentState,
      animations: { [weak self] in
          self?.squidImage.alpha = 1
        },
      completion: nil)
  }
  
  func fadeOutSquid() {
    let duration = AppDelegate.current.controls.value(ControlType.duration)
    
    UIView.animate(withDuration: duration,
     delay: 0,
     options: .beginFromCurrentState,
     animations: { [weak self] in
        self?.squidImage.alpha = 0
      },
     completion: nil)

  }
}

