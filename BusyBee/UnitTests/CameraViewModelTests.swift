//
//  CameraViewModelTests.swift
//  UserModelTests
//
//  Created by Joshua Yu  on 12/13/23.
//

import XCTest
@testable import BusyBee

class CameraViewModelTests: XCTestCase {

    func testInitialState() {
        let viewModel = CameraViewModel()

        XCTAssertFalse(viewModel.isCreatePostViewPresented)
        XCTAssertTrue(viewModel.isShareButtonEnabled)
    }

    func testToggleCreatePostView() {
        let viewModel = CameraViewModel()

        XCTAssertFalse(viewModel.isCreatePostViewPresented)
        viewModel.isCreatePostViewPresented.toggle()
        XCTAssertTrue(viewModel.isCreatePostViewPresented)
    }

    func testDisableShareButton() {
        let viewModel = CameraViewModel()

        XCTAssertTrue(viewModel.isShareButtonEnabled)
        viewModel.isShareButtonEnabled = false
        XCTAssertFalse(viewModel.isShareButtonEnabled)
    }

}
