import Foundation

class SliderControlUserDefaults {
  class func keyName(_ type: ControlType) -> String {
    return "Slider Value '\(type.rawValue)'"
  }

  class func value(_ type: ControlType) -> Double? {
    let userDefaults = UserDefaults.standard
    if let currentValue = userDefaults.object(forKey: keyName(type)) as? Double {
      return currentValue
    }
    return nil
  }

  class func saveValue(_ value: Double, type: ControlType) {
    let userDefaults = UserDefaults.standard
    userDefaults.set(value, forKey: keyName(type))
  }
}
