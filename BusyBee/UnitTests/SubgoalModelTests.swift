//
//  SubgoalModelTests.swift
//  UserModelTests
//
//  Created by Joshua Yu  on 12/6/23.
//

import XCTest
@testable import BusyBee

class SubgoalTests: XCTestCase {
  
//  @DocumentID var id: String?
//  var name: String
//  var isCompleted: Bool
//  var goalId: String

  func testInit() {

    let subgoalInstance = Subgoal(name: "get better", isCompleted: true, goalId: "1")
    let subgoalInstance2 = Subgoal(name: "it's doomed", isCompleted: false, goalId: "2")
     


     XCTAssertNotNil(subgoalInstance)
     XCTAssertNotNil(subgoalInstance.name)
     XCTAssertNotNil(subgoalInstance.isCompleted)
     XCTAssertNotNil(subgoalInstance.goalId)

     //Assert True Tests
     XCTAssertTrue(subgoalInstance.name == "get better")
     XCTAssertTrue(subgoalInstance.isCompleted == true)
     XCTAssertTrue(subgoalInstance.goalId == "1")


     //Assert False Tests
     XCTAssertFalse(subgoalInstance.name == "get worse")
     XCTAssertFalse(subgoalInstance.isCompleted == false)
     XCTAssertFalse(subgoalInstance.goalId == "4")


     XCTAssertTrue(subgoalInstance != subgoalInstance2)
     XCTAssertTrue(subgoalInstance < subgoalInstance2)

   }


}
