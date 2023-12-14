//
//  PostModelTests.swift
//  UserModelTests
//
//  Created by Joshua Yu  on 12/6/23.
//

import XCTest
@testable import BusyBee

class PostTests: XCTestCase {

//  @DocumentID var id: String?
//  var goalId: String
//  var userId: String
//  var caption: String
//  var photo: String
//  var subgoalId: String?
//  var timePosted: Date
//  var comments: [Comment]
//  var reaction1: [String]
//  var reaction2: [String]
//  var reaction3: [String]
//  var reaction4: [String]
  
  func testInit() {
    let commentInstance = Comment(userId: "1", body: "yep", timePosted: Date())


    let postInstance = Post(goalId: "1", userId: "1", caption: "yep", photo: "yep", subgoalId: "1", timePosted: Date(), comments: [commentInstance], reaction1:["yep"], reaction2:["yep"], reaction3:["yep"], reaction4:["yep"])
    
    let postInstance2 = Post(goalId: "2", userId: "2", caption: "yep", photo: "yep", subgoalId: "2", timePosted: Date(), comments: [], reaction1:["yep"], reaction2:["yep"], reaction3:["yep"], reaction4:["yep"])
     


     XCTAssertNotNil(postInstance)
     XCTAssertNotNil(postInstance.userId)
    XCTAssertNotNil(postInstance.caption)
     XCTAssertNotNil(postInstance.photo)
    XCTAssertNotNil(postInstance.subgoalId)
    XCTAssertNotNil(postInstance.timePosted)
    XCTAssertNotNil(postInstance.comments)
    XCTAssertNotNil(postInstance.reaction1)
    XCTAssertNotNil(postInstance.reaction2)
    XCTAssertNotNil(postInstance.reaction3)
    XCTAssertNotNil(postInstance.reaction4)

     //Assert True Tests
     XCTAssertTrue(postInstance.userId == "1")
     XCTAssertTrue(postInstance.caption == "yep")
    XCTAssertTrue(postInstance.photo == "yep")
    XCTAssertTrue(postInstance.subgoalId == "1")
    XCTAssertTrue(postInstance.comments == [commentInstance])
    XCTAssertTrue(postInstance.reaction1 == ["yep"])
    XCTAssertTrue(postInstance.reaction2 == ["yep"])
    XCTAssertTrue(postInstance.reaction3 == ["yep"])
    XCTAssertTrue(postInstance.reaction4 == ["yep"])

     //Assert False Tests
    XCTAssertFalse(postInstance.userId == "2")
    XCTAssertFalse(postInstance.caption == "nope")
   XCTAssertFalse(postInstance.photo == "nope")
   XCTAssertFalse(postInstance.subgoalId == "2")
   XCTAssertFalse(postInstance.comments == [])
   XCTAssertFalse(postInstance.reaction1 == ["nope"])
   XCTAssertFalse(postInstance.reaction2 == ["nope"])
   XCTAssertFalse(postInstance.reaction3 == ["nope"])
   XCTAssertFalse(postInstance.reaction4 == ["nope"])



     XCTAssertTrue(postInstance != postInstance2)
     XCTAssertTrue(postInstance < postInstance2)

   }

  

}
