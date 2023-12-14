//
//  CameraControllerTests.swift
//  UserModelTests
//
//  Created by Joshua Yu  on 12/13/23.
//

import XCTest
@testable import BusyBee // Replace with your actual app name
import AVFoundation


class CameraControllerTests: XCTestCase {
    var cameraController: CameraController!

    override func setUpWithError() throws {
        cameraController = CameraController()
    }

    override func tearDownWithError() throws {
        cameraController = nil
    }

//    func testCreateCameraView() {
//          let cameraView = cameraController.cameraView
//          XCTAssertNotNil(cameraView)
//    }

    func testCheckPermissions() {
        cameraController.start()
          XCTAssertNotNil(cameraController.cameraView)
    }

//    func testSetUp() {
//        cameraController.setUp()
//        XCTAssertTrue(cameraController.session.automaticallyConfiguresCaptureDeviceForWideColor)
//    }
//
//    func testSetUpInputs() {
//        cameraController.setUpInputs()
//        XCTAssertNotNil(cameraController.backCamera)
//        XCTAssertNotNil(cameraController.frontCamera)
//    }

//    func testSetUpOutput() {
//        cameraController.setUpOutput()
//        // Assert that the output is added to the session
//        XCTAssertTrue(cameraController.session.outputs.contains(cameraController.output))
//    }
//
//    func testStart() {
//        cameraController.start()
//        // Assert that the session is running
//        XCTAssertTrue(cameraController.session.isRunning)
//    }
//
//    func testStop() {
//        cameraController.stop()
//        // Assert that the session is not running
//        XCTAssertFalse(cameraController.session.isRunning)
//    }
//
//    func testToggleFlash() {
//        cameraController.toggleFlash()
//
//    }

//    func testFlipCamera() {
//        cameraController.flipCamera()
//
//    }

//    func testGetSettings() {
//        let settings = cameraController.getSettings()
//
//    }

//    func testTakePhoto() {
//        cameraController.takePhoto()
//
//    }

}




