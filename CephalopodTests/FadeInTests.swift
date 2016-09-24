import XCTest
import AVFoundation
@testable import Cephalopod

class FadeInTests: XCTestCase {
    
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
      super.tearDown()
  }
  
  func testFadeIn_callFinishClosure() {
    let testExpectation = expectation(description: "test expectation")
    
    // Create player instance
    let player = TestBundle.soundPlayer()
    
    // Start audio playback
    player.play()
    player.volume = 0
    
    // Fade in the sound
    let cephalopod = Cephalopod(player: player)
    
    var finishedArgument: Bool?
    
    cephalopod.fadeIn(duration: 0.1, velocity: 1, onFinished: { finished in
      finishedArgument = finished
      testExpectation.fulfill()
    })
    
    waitForExpectations(timeout: 0.2) { error in }
    
    XCTAssert(finishedArgument!)
  }
  
  func testFadeIn_cancel_callFinishClosure() {
    let testExpectation = expectation(description: "test expectation")
    
    // Create player instance
    let player = TestBundle.soundPlayer()
    
    // Start audio playback
    player.play()
    player.volume = 0
    
    // Fade in the sound
    let cephalopod = Cephalopod(player: player)
    
    var finishedArgument: Bool?
    
    cephalopod.fadeIn(duration: 0.1, velocity: 1, onFinished: { finished in
      finishedArgument = finished
      testExpectation.fulfill()
    })
    
    cephalopod.stop()
    
    waitForExpectations(timeout: 0.2) { error in }
    
    XCTAssert(finishedArgument!)
  }

}
