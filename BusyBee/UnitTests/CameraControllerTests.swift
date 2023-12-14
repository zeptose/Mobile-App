//
//  CameraControllerTests.swift
//  UserModelTests
//
//  Created by Joshua Yu  on 12/13/23.
//

//import XCTest
//@testable import BusyBee // Replace with your actual app name
//import AVFoundation
//
//
//class CameraControllerTests: XCTestCase {
//    var cameraController: CameraController!
//
//    override func setUpWithError() throws {
//        cameraController = CameraController()
//    }
//
//    override func tearDownWithError() throws {
//        cameraController = nil
//    }
//
//    func testCreateCameraView() {
//          let cameraView = cameraController.cameraView
//          XCTAssertNotNil(cameraView)
//        // Add more assertions if needed
//    }
//
//    func testCheckPermissions() {
//        cameraController.start()
//          // Assert that the permissions are correctly handled indirectly
//          XCTAssertNotNil(cameraController.cameraView)
//    }
//
//    func testSetUp() {
//        cameraController.setUp()
//        // Assert that the session is configured properly
//        XCTAssertTrue(cameraController.session.automaticallyConfiguresCaptureDeviceForWideColor)
//        // Add more assertions based on your specific implementation
//    }
//
//    func testSetUpInputs() {
//        cameraController.setUpInputs()
//        // Assert that the back and front cameras are set up correctly
//        XCTAssertNotNil(cameraController.backCamera)
//        XCTAssertNotNil(cameraController.frontCamera)
//        // Add more assertions based on your specific implementation
//    }
//
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
//        // Assert that the flash mode is toggled correctly
//        // Add more assertions based on your specific implementation
//    }
//
//    func testFlipCamera() {
//        cameraController.flipCamera()
//        // Assert that the camera is flipped correctly
//        // Add more assertions based on your specific implementation
//    }
//
//    func testGetSettings() {
//        let settings = cameraController.getSettings()
//        // Assert that the settings are configured correctly
//        // Add more assertions based on your specific implementation
//    }
//
//    func testTakePhoto() {
//        cameraController.takePhoto()
//        // Assert that a photo is captured
//        // Add more assertions based on your specific implementation
//    }
//
//
//}
