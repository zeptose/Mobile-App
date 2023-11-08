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
}
