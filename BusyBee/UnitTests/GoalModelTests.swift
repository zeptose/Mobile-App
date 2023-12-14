//
//  GoalModelTests.swift
//  UserModelTests
//
//  Created by Joshua Yu  on 12/6/23.
//

import XCTest
@testable import BusyBee

class GoalTests: XCTestCase {

    func testGoalCoding() throws {
        let goal = Goal(id: "1", name: "Test Goal", description: "Testing description", dueDate: Date(), frequency: 7, userId: "user123", progress: 0)

        let data = try JSONEncoder().encode(goal)
        let decodedGoal = try JSONDecoder().decode(Goal.self, from: data)

        XCTAssertEqual(goal, decodedGoal)
    }

    func testGoalComparison() {
        let goal1 = Goal(id: "1", name: "Goal1", description: "Description", dueDate: Date(), frequency: 7, userId: "user123", progress: 0)
        let goal2 = Goal(id: "2", name: "Goal2", description: nil, dueDate: Date(), frequency: 14, userId: "user456", progress: 50)

        XCTAssertTrue(goal1 < goal2)
        XCTAssertFalse(goal2 < goal1)
        XCTAssertFalse(goal1 == goal2)
    }


}
