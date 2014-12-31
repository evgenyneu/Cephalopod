//
//  iiSoundPlayerFader.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 31/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import FaderForAvAudioPlayer
import XCTest

class iiFaderForAvAudioPlayerTests: XCTestCase {

  let klass = iiFaderForAvAudioPlayer.self

  // Fade OUT
  // -------------------

  func testFadeOutVolumeMultiplier() {
    XCTAssertEqual(1.000, rounded(klass.fadeOutVolumeMultiplier(0,   velocity: 2)))
    XCTAssertEqual(0.737, rounded(klass.fadeOutVolumeMultiplier(0.1, velocity: 2)))
    XCTAssertEqual(0.184, rounded(klass.fadeOutVolumeMultiplier(0.5, velocity: 2)))
    XCTAssertEqual(0.040, rounded(klass.fadeOutVolumeMultiplier(0.8, velocity: 2)))
    XCTAssertEqual(0.017, rounded(klass.fadeOutVolumeMultiplier(0.9, velocity: 2)))
    XCTAssertEqual(0.000, rounded(klass.fadeOutVolumeMultiplier(1,   velocity: 2)))

    // linear
    XCTAssertEqual(0.500, rounded(klass.fadeOutVolumeMultiplier(0.5, velocity: 0)))
    XCTAssertEqual(0.300, rounded(klass.fadeOutVolumeMultiplier(0.7, velocity: 0)))

    //edge cases
    XCTAssertEqual(1.000, rounded(klass.fadeOutVolumeMultiplier(-12,  velocity: 2)))
    XCTAssertEqual(0.000, rounded(klass.fadeOutVolumeMultiplier(123,  velocity: 2)))
  }

  func testTimeValueNormalized_withDifferentVelocity() {
    XCTAssertEqual(0.003, rounded(klass.fadeOutVolumeMultiplier(0.5, velocity: 10)))
  }

  // Fade IN
  // -------------------

  func testFadeInVolumeMultiplier() {
    XCTAssertEqual(0.000, rounded(klass.fadeInVolumeMultiplier(0,   velocity: 2)))
    XCTAssertEqual(0.017, rounded(klass.fadeInVolumeMultiplier(0.1, velocity: 2)))
    XCTAssertEqual(0.184, rounded(klass.fadeInVolumeMultiplier(0.5, velocity: 2)))
    XCTAssertEqual(0.536, rounded(klass.fadeInVolumeMultiplier(0.8, velocity: 2)))
    XCTAssertEqual(0.737, rounded(klass.fadeInVolumeMultiplier(0.9, velocity: 2)))
    XCTAssertEqual(1.000, rounded(klass.fadeInVolumeMultiplier(1,   velocity: 2)))

    // linear
    XCTAssertEqual(0.500, rounded(klass.fadeInVolumeMultiplier(0.5, velocity: 0)))
    XCTAssertEqual(0.700, rounded(klass.fadeInVolumeMultiplier(0.7, velocity: 0)))

    //edge cases
    XCTAssertEqual(0.000, rounded(klass.fadeInVolumeMultiplier(-12,  velocity: 2)))
    XCTAssertEqual(1.000, rounded(klass.fadeInVolumeMultiplier(123,  velocity: 2)))
  }

  // timeFrom0To1
  // -------------------

  func testTimeValue() {
    // 0%
    var result = klass.timeFrom0To1(0, fadeDurationSeconds: 1, stepsPerSecond: 10)
    XCTAssertEqual(0.0, rounded(result))

    // 10%
    result = klass.timeFrom0To1(1, fadeDurationSeconds: 1, stepsPerSecond: 10)
    XCTAssertEqual(0.1, rounded(result))

    result = klass.timeFrom0To1(2, fadeDurationSeconds: 2, stepsPerSecond: 10)
    XCTAssertEqual(0.1, rounded(result))

    result = klass.timeFrom0To1(4, fadeDurationSeconds: 2, stepsPerSecond: 20)
    XCTAssertEqual(0.1, rounded(result))

    // 50%
    result = klass.timeFrom0To1(5, fadeDurationSeconds: 1, stepsPerSecond: 10)
    XCTAssertEqual(0.5, rounded(result))

    // 100%
    result = klass.timeFrom0To1(10, fadeDurationSeconds: 1, stepsPerSecond: 10)
    XCTAssertEqual(1.0, rounded(result))

    // Edge cases
    // -----------------

    result = klass.timeFrom0To1(-10, fadeDurationSeconds: 1, stepsPerSecond: 10)
    XCTAssertEqual(0.0, rounded(result))

    result = klass.timeFrom0To1(100, fadeDurationSeconds: 1, stepsPerSecond: 10)
    XCTAssertEqual(1.0, rounded(result))

    result = klass.timeFrom0To1(1, fadeDurationSeconds: 0, stepsPerSecond: 10)
    XCTAssertEqual(1.0, rounded(result))

    result = klass.timeFrom0To1(1, fadeDurationSeconds: 1, stepsPerSecond: 0)
    XCTAssertEqual(1.0, rounded(result))
  }

  private func rounded(value: Double) -> Double {
    let decimalDigits = 3.0
    let miltiplier = pow(10.0, decimalDigits)
    return round(value * miltiplier) / miltiplier
  }
}