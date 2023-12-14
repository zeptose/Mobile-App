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
    var userRepository: UserRepository!


    override func setUp() {
        super.setUp()
        authViewModel = AuthViewModel()
        userRepository = UserRepository()

    }

    override func tearDown() {
        authViewModel = nil
        userRepository = nil
        super.tearDown()
    }
    
}
