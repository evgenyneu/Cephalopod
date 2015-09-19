import Foundation

class ControlsStorage {
  private(set) var allArray = [ControlData]()
  private(set) var all = [ControlType:ControlData]()

  func setup() {
    allArray.append(ControlData(
      type: ControlType.duration,
      defaults: SliderDefaults(value: 3, minimumValue: 0.1, maximumValue: 10)
      ))

    allArray.append(ControlData(
      type: ControlType.velocity,
      defaults: SliderDefaults(value: 2, minimumValue: -1, maximumValue: 5)
      ))

    var activityDefaults = SliderDefaults(value: 1, minimumValue: 1, maximumValue: 4)
    activityDefaults.step = 1

    for data in allArray {
      all[data.type] = data
    }
  }

  func value(type: ControlType) -> Double {
    if let data = all[type] {
      if let sliderView = data.view {
        return sliderView.value
      } else {
        if let currentSavedValue = SliderControlUserDefaults.value(type) {
          return currentSavedValue
        }
        return data.defaults.value
      }
    }
    
    return 0
  }

  func setValue(type: ControlType, value: Double) {
    if let data = all[type] {
      if let sliderView = data.view {
        sliderView.setValue(value)
      }
    }
  }
}
