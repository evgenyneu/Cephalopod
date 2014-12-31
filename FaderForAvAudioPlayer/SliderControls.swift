//
//  SliderControlsCreate.swift
//  location-update
//
//  Created by Evgenii Neumerzhitckii on 30/11/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

class SliderControls {
  class func create(all: [ControlData], delegate: SliderControllerDelegate?,
    superview: UIView) {

    var previousControl:SliderControllerView? = nil

    for data in all {
      let control = SliderControllerView(type: data.type,
        defaults: data.defaults, delegate: delegate)

      data.view = control

      superview.addSubview(control)

      layoutControl(control, previous: previousControl)
      previousControl = control
    }
  }

  private class func layoutControl(control: UIView, previous: UIView?) {
    control.setTranslatesAutoresizingMaskIntoConstraints(false)

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
