//
//  AuthViewModelTests.swift
//  UserModelTests
//
//  Created by Joshua Yu  on 12/13/23.
//

import XCTest
@testable import BusyBee
import FirebaseAuth
import FirebaseFirestoreSwift


class AuthViewModelTests: XCTestCase {

    var authViewModel: AuthViewModel!

    override func setUp() {
        super.setUp()
        authViewModel = AuthViewModel()
    }

    override func tearDown() {
        authViewModel = nil
        super.tearDown()
    }

    
}
