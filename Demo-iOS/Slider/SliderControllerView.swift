import UIKit

class SliderControllerView: UIView {
  fileprivate var type: ControlType!
  fileprivate var label: UILabel!
  fileprivate var slider: UISlider!
  fileprivate weak var delegate: SliderControllerDelegate?

  fileprivate var defaults: SliderDefaults!
  
  func setup(_ type: ControlType, defaults: SliderDefaults, delegate: SliderControllerDelegate?) {
    
    self.type = type
    self.delegate = delegate
    self.defaults = defaults
    
    translatesAutoresizingMaskIntoConstraints = false
    
    label = UILabel()
    configureLabel()
    
    slider = UISlider()
    configureSlider(slider)
    
    SliderDefaults.set(slider, defaults: defaults)
    
    if let valueFromDetauls = userDefaultsValue {
      slider.value = Float(valueFromDetauls)
    }
    
    saveValueInUserDefaults()
    updateLabel()
  }

  var value: Double {
    return Double(slider.value)
  }

  fileprivate func configureLabel() {
    label.translatesAutoresizingMaskIntoConstraints = false
    addSubview(label)

    SliderControllerView.positionLabel(label, superview: self)
  }

  fileprivate class func positionLabel(_ label: UIView, superview: UIView) {
    iiLayout.alignTop(label, anotherView: superview)
    iiLayout.fullWidthInParent(label)
  }

  fileprivate func configureSlider(_ slider: UISlider) {
    slider.translatesAutoresizingMaskIntoConstraints = false
    addSubview(slider)

    slider.addTarget(self, action: #selector(SliderControllerView.sliderChanged(_:)), for: UIControlEvents.valueChanged)

    slider.addTarget(self, action: #selector(SliderControllerView.sliderChangeEnded(_:)), for: UIControlEvents.touchUpInside)


    SliderControllerView.positionSlider(label, slider: slider, superview: self)
  }

  func sliderChanged(_ slider: UISlider) {

    if defaults.step != 0 {
      slider.value = Float(defaults.step * round(Double(slider.value) / defaults.step))
    }

    saveValueInUserDefaults()

    updateLabel()
  }

  fileprivate func updateLabel() {
    SliderControllerView.updateSliderLabel(slider, label: label, caption: type.rawValue,
      valueNames: defaults.valueNames)
  }

  func sliderChangeEnded(_ slider: UISlider) {
    delegate?.sliderControllerDelegate_OnChangeEnded()
  }

  fileprivate class func updateSliderLabel(_ slider: UISlider, label: UILabel, caption: String,
    valueNames: [Double: String]) {

    var value = ""
    if let valueName = valueNames[Double(slider.value)] {
      value = "\(valueName)"
    } else {
      value = formatValue(Double(slider.value))
    }

    label.text = "\(caption): \(value)"
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  fileprivate class func positionSlider(_ caption: UIView, slider: UIView, superview: UIView) {
    iiLayout.fullWidthInParent(slider)
    iiLayout.stackVertically(caption, viewNext: slider, margin: 3)
    iiLayout.alignBottom(slider, anotherView: superview)
  }

  fileprivate class func formatValue(_ value: Double) -> String {
    return String(format: "%.3f", value)
  }

  func resetToDefault() {
    SliderDefaults.set(slider, defaults: defaults)
    saveValueInUserDefaults()
    updateLabel()
  }

  func setValue(_ value: Double) {
    slider.value = Float(value)
    saveValueInUserDefaults()
    updateLabel()
  }

  // User defauts
  // --------------------

  fileprivate var defaultsKey: String {
    return  SliderControlUserDefaults.keyName(type)
  }

  fileprivate var userDefaultsValue: Double? {
    return SliderControlUserDefaults.value(type)
  }

  fileprivate func saveValueInUserDefaults() {
    SliderControlUserDefaults.saveValue(Double(slider.value), type: type)
  }
}
