//
//  PostModelTests.swift
//  UserModelTests
//
//  Created by Joshua Yu  on 12/6/23.
//

import XCTest
@testable import BusyBee

class PostTests: XCTestCase {

    func testPostCoding() throws {
        let post = Post(id: "1", goalId: "goal123", userId: "user123", caption: "Test Caption", photo: "test.jpg", subgoalId: "subgoal123", timePosted: Date(), comments: [], reaction1: ["user1", "user2"], reaction2: ["user3"], reaction3: [], reaction4: ["user4"])

        let data = try JSONEncoder().encode(post)
        let decodedPost = try JSONDecoder().decode(Post.self, from: data)

        XCTAssertEqual(post, decodedPost)
    }

    func testPostComparison() {
        let post1 = Post(id: "1", goalId: "goal123", userId: "user123", caption: "Caption1", photo: "photo1.jpg", subgoalId: nil, timePosted: Date(), comments: [], reaction1: [], reaction2: [], reaction3: [], reaction4: [])
        let post2 = Post(id: "2", goalId: "goal456", userId: "user456", caption: "Caption2", photo: "photo2.jpg", subgoalId: "subgoal456", timePosted: Date().addingTimeInterval(3600), comments: [], reaction1: ["user1"], reaction2: [], reaction3: [], reaction4: ["user2"])

        XCTAssertTrue(post1 < post2)
        XCTAssertFalse(post2 < post1)
        XCTAssertFalse(post1 == post2)
    }


}
