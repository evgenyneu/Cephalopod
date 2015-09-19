import Foundation

class SliderControlUserDefaults {
  class func keyName(type: ControlType) -> String {
    return "Slider Value '\(type.rawValue)'"
  }

  class func value(type: ControlType) -> Double? {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    if let currentValue = userDefaults.objectForKey(keyName(type)) as? Double {
      return currentValue
    }
    return nil
  }

  class func saveValue(value: Double, type: ControlType) {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    userDefaults.setDouble(value, forKey: keyName(type))
  }
}
