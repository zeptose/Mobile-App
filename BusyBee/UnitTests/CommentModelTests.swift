//
//  CommentModelTests.swift
//  UserModelTests
//
//  Created by Joshua Yu  on 12/6/23.
//

import XCTest
@testable import BusyBee

class CommentTests: XCTestCase {

    func testCommentCoding() throws {
        let comment = Comment(id: "1", userId: "user123", body: "Test Comment", timePosted: Date())

        let data = try JSONEncoder().encode(comment)
        let decodedComment = try JSONDecoder().decode(Comment.self, from: data)

        XCTAssertEqual(comment, decodedComment)
    }

    func testCommentComparison() {
        let comment1 = Comment(id: "1", userId: "user123", body: "Comment1", timePosted: Date())
        let comment2 = Comment(id: "2", userId: "user456", body: "Comment2", timePosted: Date().addingTimeInterval(3600))

        XCTAssertTrue(comment1 < comment2)
        XCTAssertFalse(comment2 < comment1)
        XCTAssertFalse(comment1 == comment2)
    }


}
