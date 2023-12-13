//
//  UserControllerTests.swift
//  UserModelTests
//
//  Created by Joshua Yu  on 12/13/23.
//

import XCTest
@testable import BusyBee // Import your app module

class UserControllerTests: XCTestCase {

    var userController: UserController!

    override func setUp() {
        super.setUp()
        userController = UserController()
    }

    override func tearDown() {
        userController = nil
        super.tearDown()
    }

    func testGetUserFriends() {
        // Create test data
        let currentUser = User(id: "1", username: "CurrentUser", bio: "Bio", goals: [], posts: [], follows: ["2", "3"])
        let user1 = User(id: "2", username: "User1", bio: "Bio1", goals: [], posts: [], follows: [])
        let user2 = User(id: "3", username: "User2", bio: "Bio2", goals: [], posts: [], follows: [])
        let user3 = User(id: "4", username: "User3", bio: "Bio3", goals: [], posts: [], follows: [])
        userController.users = [user1, user2, user3]

        // Test the method
        let result = userController.getUserFriends(currentUser: currentUser)

        // Assert the result
        XCTAssertEqual(result, [user1, user2])
    }

    // Repeat similar tests for other methods...

    func testUnfollowFriend() {
        // Create test data
        let currentUser = User(id: "1", username: "CurrentUser", bio: "Bio", goals: [], posts: [], follows: ["2", "3"])
        let user1 = User(id: "2", username: "User1", bio: "Bio1", goals: [], posts: [], follows: [])
        let user2 = User(id: "3", username: "User2", bio: "Bio2", goals: [], posts: [], follows: [])
        userController.users = [user1, user2]

        // Test the method
        userController.unfollowFriend(currentUser: currentUser, unfollow: user1)

        // Assert the result
        XCTAssertTrue(currentUser.follows.contains("2"))
        XCTAssertFalse(currentUser.follows.contains("4"))
    }

    // Add more tests for other methods...

}

//import XCTest
//@testable import BusyBee // Import your app module
//
//class UserControllerTests: XCTestCase {
//
//    var userController: UserController!
//
//    override func setUp() {
//        super.setUp()
//        userController = UserController()
//    }
//
//    override func tearDown() {
//        userController = nil
//        super.tearDown()
//    }
//
//    // Existing tests...
//
//    func testGetUserFromId() {
//        // Create test data
//        let user1 = User(id: "1", username: "User1", bio: "Bio1", goals: [], posts: [], follows: [])
//        let user2 = User(id: "2", username: "User2", bio: "Bio2", goals: [], posts: [], follows: [])
//        userController.users = [user1, user2]
//
//        // Test the method
//        let result = userController.getUserFromId(userId: "1")
//
//        // Assert the result
//        XCTAssertEqual(result, user1)
//    }
//
//    func testGetNewFollowers() {
//        // Test the method
//        let result = userController.getNewFollowers(beforeUpdate: ["1", "2"], afterUpdate: ["2", "3"])
//
//        // Assert the result
//        XCTAssertEqual(result, ["3"])
//    }
//
//    func testUpdateProfile() {
//        // Create test data
//        var user = User(id: "1", username: "User1", bio: "Bio1", goals: [], posts: [], follows: [])
//        let username = "UpdatedUsername"
//        let bio = "UpdatedBio"
//
//        // Test the method
//        userController.updateProfile(user: user, username: username, bio: bio)
//
//        // Assert the result
//        XCTAssertEqual(user.username, username)
//        XCTAssertEqual(user.bio, bio)
//    }
//
//    func testFollowFriend() {
//        // Create test data
//        var currentUser = User(id: "1", username: "CurrentUser", bio: "Bio", goals: [], posts: [], follows: [])
//        let friendToFollow = User(id: "2", username: "FriendToFollow", bio: "FriendBio", goals: [], posts: [], follows: [])
//
//        // Test the method
//        userController.followFriend(currentUser: currentUser, follow: friendToFollow)
//
//        // Assert the result
//        XCTAssertTrue(currentUser.follows.contains("2"))
//    }
//
//    func testIsFollowing() {
//        // Create test data
//        let currentUser = User(id: "1", username: "CurrentUser", bio: "Bio", goals: [], posts: [], follows: ["2", "3"])
//        let userToCheck = User(id: "2", username: "UserToCheck", bio: "UserBio", goals: [], posts: [], follows: [])
//
//        // Test the method
//        let result = userController.isFollowing(currentUser: currentUser, otherUser: userToCheck)
//
//        // Assert the result
//        XCTAssertTrue(result)
//    }
//
//    func testCurrentUserIsFollowingFollower() {
//        // Create test data
//        let currentUser = User(id: "1", username: "CurrentUser", bio: "Bio", goals: [], posts: [], follows: ["2", "3"])
//        let followerId = "2"
//
//        // Test the method
//        let result = userController.currentUserIsFollowingFollower(currentUser: currentUser, followerId: followerId)
//
//        // Assert the result
//        XCTAssertTrue(result)
//    }
//}
