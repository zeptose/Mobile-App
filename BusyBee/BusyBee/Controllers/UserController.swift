//
//  UserController.swift
//  BusyBee
//
//  Created by elaine wang on 10/31/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserController: ObservableObject {
  @Published var userRepository: UserRepository = UserRepository()
  @Published var users: [User] = []
//  @Published var follows: [Follow] = []
//  @Published var isFriend: Bool = false
  
  init () {
    self.userRepository.get({(users) -> Void in
          self.users = users
      })
    }
    
    func getUserFriends(currentUser: User) -> [User] {
      return self.users.filter { currentUser.follows.contains($0.id) }
    }
    
    func getUserFromId(userId: String) -> User? {
      let temp = self.users.first( where: {$0.id == userId} )
      if let ourUser = temp {
        return ourUser
      } else {
        return nil
      }
    }
    
      func updateProfile(user: User, username: String, bio: String)  {
        var temp = user
        temp.bio = bio
        temp.username = username
        userRepository.update(temp)
      }
      
      func followFriend(currentUser: User, follow: User) {
        var curr = currentUser
        curr.follows.append(follow.id)
//        curr.follows = currentFollows + [follow.id]
        userRepository.update(curr)
      }
      func isFollowing(currentUser: User, otherUser: User) -> Bool {
          return currentUser.follows.contains(otherUser.id)
      }

      func unfollowFriend(currentUser: User, unfollow: User) {
          var curr = currentUser
          let ind = curr.follows.firstIndex(of: unfollow.id)
          print("New Following List: \(curr.follows)")
          curr.follows.remove(at: ind!)
          userRepository.update(curr)
      }
//      func toggleFriendStatus(currentUser: User, friend: User) {
//        print("Current Following List: \(currentUser.follows)")
//        print("toggling: \(friend.username)")
//          if isFollowing(currentUser: currentUser, otherUser: friend) {
//              print("Unfollowiing: \(friend.username)")
//                  unfollowFriend(currentUser: currentUser, unfollow: friend)
//              } else {
//                print("Following: \(friend.username)")
//                  followFriend(currentUser: currentUser, follow: friend)
//              }
//
//              isFriend.toggle()
//      }

}
