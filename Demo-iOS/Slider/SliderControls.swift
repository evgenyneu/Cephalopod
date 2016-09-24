import UIKit

class SliderControls {
  class func create(_ all: [ControlData], delegate: SliderControllerDelegate?,
    superview: UIView) {

    var previousControl:SliderControllerView? = nil

    for data in all {
      let control = SliderControllerView()
      control.setup(data.type, defaults: data.defaults, delegate: delegate)

      data.view = control

      superview.addSubview(control)

      layoutControl(control, previous: previousControl)
      previousControl = control
    }
  }

  fileprivate class func layoutControl(_ control: UIView, previous: UIView?) {
    control.translatesAutoresizingMaskIntoConstraints = false

    if let currentPrevious = previous {
      iiLayout.stackVertically(currentPrevious, viewNext: control, margin: 15)
    } else {
      if let currentSuperview = control.superview {
        iiLayout.alignTop(control, anotherView: currentSuperview)
      }
    }

    iiLayout.fullWidthInParent(control)
  }
}
