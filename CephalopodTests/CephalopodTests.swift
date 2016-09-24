import XCTest
import AVFoundation
@testable import Cephalopod

class CephalopodTests: XCTestCase {
    
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
      super.tearDown()
  }
  
  func testExample() {
    var playerInstance: AVAudioPlayer?
    var cephalopod: Cephalopod?
    
    // Create player instance
    let player = TestBundle.soundPlayer()
    playerInstance = player
  }
}
