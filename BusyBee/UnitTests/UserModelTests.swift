//
//  UserModelTests.swift
//  UserModelTests
//
//  Created by Joshua Yu  on 12/6/23.
//

import XCTest
@testable import BusyBee


class UserModelTests: XCTestCase {

    func testUserCoding() throws {
        let user = User(id: "1", username: "testUser", bio: "Testing bio", goals: [], posts: [], follows: ["user1", "user2"])

        let data = try JSONEncoder().encode(user)
        let decodedUser = try JSONDecoder().decode(User.self, from: data)

        XCTAssertEqual(user, decodedUser)
    }

    func testUserComparison() {
        let user1 = User(id: "1", username: "user1", bio: nil, goals: [], posts: [], follows: [])
        let user2 = User(id: "2", username: "user2", bio: "Bio", goals: [], posts: [], follows: [])

        XCTAssertTrue(user1 < user2)
        XCTAssertFalse(user2 < user1)
        XCTAssertFalse(user1 == user2)
    }


}
