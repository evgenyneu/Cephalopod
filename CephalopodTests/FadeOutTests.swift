import XCTest
import AVFoundation
@testable import Cephalopod

class FadeOutTests: XCTestCase {
  
  var player: AVAudioPlayer!
  var cephalopod: Cephalopod!
  
  override func setUp() {
    super.setUp()
    
    player = TestBundle.soundPlayer()
    player.volume = 1
    cephalopod = Cephalopod(player: player)
  }
  
  func testStartVolume() {
    XCTAssertEqual(1.0, player.volume)
  }
  
  func testFadeOut_callFinishClosure() {
    let testExpectation = expectation(description: "test expectation")
    
    var finishedArgument: Bool?
    
    cephalopod.fadeOut(duration: 0.1, velocity: 1, onFinished: { finished in
      finishedArgument = finished
      testExpectation.fulfill()
    })
    
    waitForExpectations(timeout: 0.2) { error in }
    
    XCTAssert(finishedArgument!)
    XCTAssertEqual(0.0, player.volume)
  }
  
  func testFadeOut_cancelByCallingStop_callFinishClosure() {
    let testExpectation = expectation(description: "test expectation")
    
    var finishedArgument: Bool?
    
    cephalopod.fadeOut(duration: 0.1, velocity: 1, onFinished: { finished in
      finishedArgument = finished
      testExpectation.fulfill()
    })
    
    cephalopod.stop()
    
    waitForExpectations(timeout: 0.2) { error in }
    
    XCTAssertFalse(finishedArgument!)
    XCTAssertEqual(1.0, player.volume)
  }
  
  func testFadeOut_cancelByCallingFadeAgain_callFinishClosure() {
    let testExpectation = expectation(description: "test expectation")
    
    var finishedArgument: Bool?
    
    cephalopod.fadeOut(duration: 0.1, velocity: 1, onFinished: { finished in
      finishedArgument = finished
      testExpectation.fulfill()
    })
    
    cephalopod.fadeOut()
    
    waitForExpectations(timeout: 0.2) { error in }
    
    XCTAssertFalse(finishedArgument!)
    XCTAssertEqual(1.0, player.volume)
  }
  
}
