//
// Creates a timer that executes code after delay. The timer lives in an instance of `AutoCancellingTimer` class and is automatically canceled when this instance is deallocated.
// This is an auto-canceling alternative to timer created with `dispatch_after` function.
//
// Source: https://gist.github.com/evgenyneu/516f7dcdb5f2f73d7923
//
// Usage
// -----
//
//     class MyClass {
//         var timer: AutoCancellingTimer? // Timer will be cancelled with MyCall is deallocated
//
//         func runTimer() {
//             timer = AutoCancellingTimer(interval: delaySeconds, repeats: true) {
//                ... code to run
//             }
//         }
//     }
//
//
//  Cancel the timer
//  --------------------
//
//  Timer is canceled automatically when it is deallocated. You can also cancel it manually:
//
//     timer.cancel()
//

import Foundation

final class AutoCancellingTimer {
  private var timer: AutoCancellingTimerInstance?
  
  init(interval: TimeInterval, repeats: Bool = false, callback: @escaping ()->()) {
    timer = AutoCancellingTimerInstance(interval: interval, repeats: repeats, callback: callback)
  }
  
  deinit {
    timer?.cancel()
  }
  
  func cancel() {
    timer?.cancel()
  }
}

final class AutoCancellingTimerInstance: NSObject {
  private let repeats: Bool
  private var callback: () -> Void
  private var interval: TimeInterval
  private var workItem: DispatchWorkItem?

  init(interval: TimeInterval, repeats: Bool = false, callback: @escaping () -> Void) {
    self.repeats = repeats
    self.callback = callback
    self.interval = interval

    super.init()

    scheduleTimer()
  }

  func cancel() {
    workItem?.cancel()
  }

  private func scheduleTimer() {
    let workItem = DispatchWorkItem { [weak self] in
      self?.timerFired()
    }
    self.workItem = workItem

    cephalopodDispatchQueue.asyncAfter(deadline: .now() + .microseconds(Int(interval * 1_000_000)), execute: workItem)
  }

  func timerFired() {
    self.callback()
    if repeats { scheduleTimer() }
  }
}

let cephalopodDispatchQueue = DispatchQueue(label: "Cephalopod Queue")
