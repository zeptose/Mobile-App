
//  CommentModelTests.swift
//  UserModelTests
//
//  Created by Joshua Yu  on 12/6/23.


import XCTest
@testable import BusyBee

class CommentTests: XCTestCase {

  func testInit() {
//    @DocumentID var id: String?
//    var userId: String
//    var body: String
//    var timePosted: Date

    let commentInstance = Comment(userId: "1", body: "yep", timePosted: Date())
    
    let commentInstance2 = Comment(userId: "2", body: "nope", timePosted: Date())
     


     XCTAssertNotNil(commentInstance)
     XCTAssertNotNil(commentInstance.userId)
     XCTAssertNotNil(commentInstance.body)
     XCTAssertNotNil(commentInstance.timePosted)

     //Assert True Tests
     XCTAssertTrue(commentInstance.userId == "1")
     XCTAssertTrue(commentInstance.body == "yep")



     //Assert False Tests
     XCTAssertFalse(commentInstance.userId == "3")
     XCTAssertFalse(commentInstance.body == "of course")



     XCTAssertTrue(commentInstance != commentInstance2)
     XCTAssertTrue(commentInstance < commentInstance2)

   }


}
