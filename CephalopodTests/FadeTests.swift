import XCTest
import AVFoundation
@testable import Cephalopod

class FadeTests: XCTestCase {
  
  var player: AVAudioPlayer!
  var cephalopod: Cephalopod!
  
  override func setUp() {
    super.setUp()
    
    player = TestBundle.soundPlayer()
    player.volume = 0.234
    cephalopod = Cephalopod(player: player)
  }
  
  func testStartVolume() {
    XCTAssertEqual(0.234, player.volume)
  }
  
  func testFadeIn_callFinishClosure() {
    let testExpectation = expectation(description: "test expectation")
    
    var finishedArgument: Bool?
    
    cephalopod.fade(fromVolume: 0.041, toVolume: 0.864, duration: 0.1, velocity: 1, onFinished: { finished in
      finishedArgument = finished
      testExpectation.fulfill()
    })
    
    waitForExpectations(timeout: 0.2) { error in }
    
    XCTAssert(finishedArgument!)
    XCTAssertEqual(0.864, player.volume)
  }
  
  func testFadeOut_callFinishClosure() {
    let testExpectation = expectation(description: "test expectation")
    
    var finishedArgument: Bool?
    
    cephalopod.fade(fromVolume: 0.911, toVolume: 0.191, duration: 0.1, velocity: 1, onFinished: { finished in
      finishedArgument = finished
      testExpectation.fulfill()
    })
    
    waitForExpectations(timeout: 0.2) { error in }
    
    XCTAssert(finishedArgument!)
    XCTAssertEqual(0.191, player.volume)
  }
  
  func testFade_cancelByCallingStop_callFinishClosure() {
    let testExpectation = expectation(description: "test expectation")
    
    var finishedArgument: Bool?
    
    cephalopod.fade(fromVolume: 0.041, toVolume: 0.864, velocity: 1, onFinished: { finished in
      finishedArgument = finished
      testExpectation.fulfill()
    })
    
    cephalopod.stop()
    
    waitForExpectations(timeout: 0.2) { error in }
    
    XCTAssertFalse(finishedArgument!)
    XCTAssertEqual(0.041, player.volume)
  }
  
  func testFade_cancelByCallingFadeAgain_callFinishClosure() {
    let testExpectation = expectation(description: "test expectation")
    
    var finishedArgument: Bool?
    
    cephalopod.fade(fromVolume: 0.041, toVolume: 0.864, velocity: 1, onFinished: { finished in
      finishedArgument = finished
      testExpectation.fulfill()
    })
    
    cephalopod.fade(fromVolume: 0.041, toVolume: 0.864, velocity: 1, onFinished: { _ in })
      
    waitForExpectations(timeout: 0.2) { error in }
    
    XCTAssertFalse(finishedArgument!)
    XCTAssertEqual(0.041, player.volume)
  }
  
}
