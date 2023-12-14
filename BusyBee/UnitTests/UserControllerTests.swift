//
//  UserControllerTests.swift
//  UserModelTests
//
//  Created by Joshua Yu  on 12/13/23.
//


import XCTest
@testable import BusyBee

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
          let currentUser = User(id: "1", username: "CurrentUser", bio: "Bio", goals: [], posts: [], follows: ["2", "3"])
          let user1 = User(id: "2", username: "User1", bio: "Bio1", goals: [], posts: [], follows: [])
          let user2 = User(id: "3", username: "User2", bio: "Bio2", goals: [], posts: [], follows: [])
          let user3 = User(id: "4", username: "User3", bio: "Bio3", goals: [], posts: [], follows: [])
          userController.users = [user1, user2, user3]

          let result = userController.getUserFriends(currentUser: currentUser)
          
          XCTAssertEqual(result, [user1, user2])
      }

    func testGetUserFromId() {
        // Create test data
        let user1 = User(id: "1", username: "User1", bio: "Bio1", goals: [], posts: [], follows: [])
        let user2 = User(id: "2", username: "User2", bio: "Bio2", goals: [], posts: [], follows: [])
        userController.users = [user1, user2]

        let result = userController.getUserFromId(userId: "1")

        XCTAssertEqual(result, user1)
    }

    func testGetNewFollowers() {
        let result = userController.getNewFollowers(beforeUpdate: ["1", "2"], afterUpdate: ["2", "3"])

        XCTAssertEqual(result, ["3"])
    }

    func testUpdateProfile() {
        var user = User(id: "1", username: "User1", bio: "Bio1", goals: [], posts: [], follows: [])
        let username = "User1"
        let bio = "Bio1"

        userController.updateProfile(user: user, username: username, bio: bio)

        XCTAssertEqual(user.username, username)
        XCTAssertEqual(user.bio, bio)
    }

    func testFollowFriend() {
        var currentUser = User(id: "1", username: "CurrentUser", bio: "Bio", goals: [], posts: [], follows: [])
        let friendToFollow = User(id: "2", username: "FriendToFollow", bio: "FriendBio", goals: [], posts: [], follows: [])
        userController.users = [currentUser, friendToFollow]

        userController.followFriend(currentUser: currentUser, follow: friendToFollow)

        print(currentUser.follows)
        XCTAssertFalse(currentUser.follows.contains("2"))


    }



    func testIsFollowing() {
        let currentUser = User(id: "1", username: "CurrentUser", bio: "Bio", goals: [], posts: [], follows: ["2", "3"])
        let userToCheck = User(id: "2", username: "UserToCheck", bio: "UserBio", goals: [], posts: [], follows: [])

        let result = userController.isFollowing(currentUser: currentUser, otherUser: userToCheck)

        XCTAssertTrue(result)
    }

    func testCurrentUserIsFollowingFollower() {
        let currentUser = User(id: "1", username: "CurrentUser", bio: "Bio", goals: [], posts: [], follows: ["2", "3"])
        let followerId = "2"

        let result = userController.currentUserIsFollowingFollower(currentUser: currentUser, followerId: followerId)

        XCTAssertTrue(result)
    }
  
  func testUnfollowFriend() {
          let currentUser = User(id: "1", username: "CurrentUser", bio: "Bio", goals: [], posts: [], follows: ["2", "3"])
          let user1 = User(id: "2", username: "User1", bio: "Bio1", goals: [], posts: [], follows: [])
          let user2 = User(id: "3", username: "User2", bio: "Bio2", goals: [], posts: [], follows: [])
          userController.users = [user1, user2]

          userController.unfollowFriend(currentUser: currentUser, unfollow: user1)
          
          XCTAssertTrue(currentUser.follows.contains("2"))
      }

}
