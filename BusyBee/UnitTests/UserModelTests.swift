//
//  UserModelTests.swift
//  UserModelTests
//
//  Created by Joshua Yu  on 12/6/23.
//

import XCTest
@testable import BusyBee


class UserModelTests: XCTestCase {

  func testInit() {
//    var id: String
//    var username: String
//    var bio: String?
//    var goals: [Goal]
//    var posts: [Post]
//    var follows: [String]
    
//    var id: String
//    var name: String
//    var description: String?
//    var dueDate: Date
//    var frequency: Int
//    var userId: String
//    var progress: Int
    
    let goal1 = Goal(id: UUID().uuidString, name:"Best Goal", description:"This is the best goal", dueDate: Date(), frequency: 1, userId: "1", progress: 15)
    
    let goal2 = Goal(id: UUID().uuidString, name:"Worst Goal", description:"This is the best goal", dueDate: Date(), frequency: 1, userId: "1", progress: 15)

    let userInstance = User(id: UUID().uuidString, username: "MonkeyJerr", bio: "Achieving Goals", goals: [goal1], posts: [], follows: ["Zeptose","Mastermind"])
    
    let userInstance2 = User(id: UUID().uuidString, username: "Zeptose", bio: "Playing video games", goals: [goal1], posts: [], follows: ["Zeptose","Mastermind"])
     


     XCTAssertNotNil(userInstance)
     XCTAssertNotNil(userInstance.id)
     XCTAssertNotNil(userInstance.username)
     XCTAssertNotNil(userInstance.bio)
     XCTAssertNotNil(userInstance.goals)
     XCTAssertNotNil(userInstance.posts)
     XCTAssertNotNil(userInstance.follows)

     //Assert True Tests
     XCTAssertTrue(userInstance.username == "MonkeyJerr")
     XCTAssertTrue(userInstance.bio == "Achieving Goals")
     XCTAssertTrue(userInstance.goals == [goal1])
     XCTAssertTrue(userInstance.posts == [])
     XCTAssertTrue(userInstance.follows == ["Zeptose","Mastermind"])



     //Assert False Tests
     XCTAssertFalse(userInstance.username == "Zeptose")
     XCTAssertFalse(userInstance.bio == "Not achieving goals")
     XCTAssertFalse(userInstance.goals == [goal2])
//     XCTAssertFalse(userInstance.posts == [])
     XCTAssertFalse(userInstance.follows == ["Zeptose","Mastermind", "Joe"])
     
     
     XCTAssertTrue(userInstance != userInstance2)
     XCTAssertTrue(userInstance < userInstance2)

   }


}
