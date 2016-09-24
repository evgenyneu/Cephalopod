import XCTest
import AVFoundation
@testable import Cephalopod

class FadeInTests: XCTestCase {
  
  var player: AVAudioPlayer!
  var cephalopod: Cephalopod!
    
  override func setUp() {
    super.setUp()
    
    player = TestBundle.soundPlayer()
    cephalopod = Cephalopod(player: player)
  }
  
  override func tearDown() {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
      super.tearDown()
  }
  
  func testFadeIn_callFinishClosure() {
    let testExpectation = expectation(description: "test expectation")
    
    var finishedArgument: Bool?
    
    cephalopod.fadeIn(duration: 0.1, velocity: 1, onFinished: { finished in
      finishedArgument = finished
      testExpectation.fulfill()
    })
    
    waitForExpectations(timeout: 0.2) { error in }
    
    XCTAssert(finishedArgument!)
  }
  
  func testFadeIn_cancelByCallingStop_callFinishClosure() {
    let testExpectation = expectation(description: "test expectation")
    
    var finishedArgument: Bool?
    
    cephalopod.fadeIn(duration: 0.1, velocity: 1, onFinished: { finished in
      finishedArgument = finished
      testExpectation.fulfill()
    })
    
    cephalopod.stop()
    
    waitForExpectations(timeout: 0.2) { error in }
    
    XCTAssertFalse(finishedArgument!)
  }
  
  func testFadeIn_cancelByCallingFadeAgain_callFinishClosure() {
    let testExpectation = expectation(description: "test expectation")
    
    var finishedArgument: Bool?
    
    cephalopod.fadeIn(duration: 0.1, velocity: 1, onFinished: { finished in
      finishedArgument = finished
      testExpectation.fulfill()
    })
    
    cephalopod.fadeIn()
    
    waitForExpectations(timeout: 0.2) { error in }
    
    XCTAssertFalse(finishedArgument!)
  }

}
