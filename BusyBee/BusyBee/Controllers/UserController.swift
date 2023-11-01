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
  
  func addNewUser(username: String, password: String, bio: String?) {
    let id = UUID().uuidString
    let posts: [Post] = []
    let follows: [User] = []
    let goals: [Goal] = []
    
    let newUser = User(id: id,
                       username: username,
                       bio: bio,
                       goals: goals,
                       posts: posts,
                       follows: follows)
    userRepository.create(newUser)
    
  }
}
