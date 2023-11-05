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
  
    func followFriend(currentUser: User, follow: User) {
        var following = currentUser.follows
        following.append(follow)
        userRepository.update(currentUser)
    }
    
  
}
