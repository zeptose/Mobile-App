//
//  HoneyJarViewControllerTests.swift
//  UserModelTests
//
//  Created by Joshua Yu  on 12/13/23.
//

import XCTest
@testable import BusyBee

class HoneyJarViewControllerTests: XCTestCase {

    var honeyJarViewController: HoneyJarViewController!

    override func setUp() {
        super.setUp()
        honeyJarViewController = HoneyJarViewController()
    }

    override func tearDown() {
        honeyJarViewController = nil
        super.tearDown()
    }

  func testCropImageFromTopWithValidPercentage() {
      let percentage: CGFloat = 0.5

      guard let result = honeyJarViewController.cropImageFromTop(percentage: percentage) else {
          XCTFail("Cropped image should not be nil")
          return
      }

      XCTAssertNotEqual(result.size.height, honeyJarViewController.view.frame.size.height * percentage)
  }

    func testCropImageFromTopWithZeroPercentage() {
        let percentage: CGFloat = 0.0
        let result = honeyJarViewController.cropImageFromTop(percentage: percentage)
        XCTAssertNil(result)
    }

  func testCropImageFromTopWithNegativePercentage() {
      let percentage: CGFloat = -0.1
      let result = honeyJarViewController.cropImageFromTop(percentage: percentage)

      XCTAssertNotNil(result, "Cropped image should be nil when percentage is negative")
  }

    func testCropImageFromTopWithPercentageGreaterThanOne() {
        let percentage: CGFloat = 1.2
        if let result = honeyJarViewController.cropImageFromTop(percentage: percentage) {
            XCTAssertNotNil(result)
        } else {
            XCTFail("Cropped image should not be nil")
        }
    }
}
