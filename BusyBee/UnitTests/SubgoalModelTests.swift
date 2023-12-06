//
//  SubgoalModelTests.swift
//  UserModelTests
//
//  Created by Joshua Yu  on 12/6/23.
//

import XCTest
@testable import BusyBee

class SubgoalTests: XCTestCase {

    func testSubgoalCoding() throws {
        let subgoal = Subgoal(id: "1", name: "Test Subgoal", isCompleted: false, goalId: "goal123")

        let data = try JSONEncoder().encode(subgoal)
        let decodedSubgoal = try JSONDecoder().decode(Subgoal.self, from: data)

        XCTAssertEqual(subgoal, decodedSubgoal)
    }

    func testSubgoalComparison() {
        let subgoal1 = Subgoal(id: "1", name: "Subgoal1", isCompleted: false, goalId: "goal123")
        let subgoal2 = Subgoal(id: "2", name: "Subgoal2", isCompleted: true, goalId: "goal456")

        XCTAssertTrue(subgoal1 < subgoal2)
        XCTAssertFalse(subgoal2 < subgoal1)
        XCTAssertFalse(subgoal1 == subgoal2)
    }


}
