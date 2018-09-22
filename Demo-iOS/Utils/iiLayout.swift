//
//  iiLayout.swift
//  SpringAnimationCALayer
//
//  Created by Evgenii Neumerzhitckii on 2/11/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

class iiLayout {
  class func fullWidthInParent(_ view: UIView) {
    view.superview?.addConstraints(
      NSLayoutConstraint.constraints(
        withVisualFormat: "|[view]|", options: [], metrics: nil,
        views: ["view": view]))
  }

  class func stackVertically(_ viewPrevious: UIView, viewNext: UIView, margin: Int = 0) {
    viewPrevious.superview?.addConstraints(
      NSLayoutConstraint.constraints(
        withVisualFormat: "V:[previous]-\(margin)-[next]", options: [], metrics: nil,
        views: ["previous": viewPrevious, "next": viewNext]))
  }

  class func alignTop(_ view: UIView, anotherView: UIView, margin:CGFloat = 0) {
    view.superview?.addConstraint(
      NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.top,
                         relatedBy: NSLayoutConstraint.Relation.equal, toItem: anotherView,
                         attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: margin))
  }

  class func alignBottom(_ view: UIView, anotherView: UIView, margin:CGFloat = 0) {
    view.superview?.addConstraint(
      NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.bottom,
                         relatedBy: NSLayoutConstraint.Relation.equal, toItem: anotherView,
                         attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: margin))
  }
}
