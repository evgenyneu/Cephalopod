import UIKit
import AVFoundation

class TestBundle {
  class func soundPath() -> String {
    return Bundle(for: self).path(forResource: "squid", ofType: "mp3")!
  }
  
  class func soundPlayer() -> AVAudioPlayer {
    let path = soundPath()
    return try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
  }
}
