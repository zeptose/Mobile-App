//
//  FirebaseController.swift
//  BusyBee
//
//  Created by elaine wang on 10/25/23.
//

import Foundation

import FirebaseFirestore
import FirebaseFirestoreSwift

class FirebaseController: ObservableObject {
  // Set up properties here
  private let store = Firestore.firestore()
  let usersCollection = Firestore.firestore().collection("users")
  
  @Published var users: [User] = []
  
  init() {
    
  }

  func create(_ user: User) {
     do {
       let newUser = user
       _ = try store.collection("users").addDocument(from: newUser)
     } catch {
       fatalError("Unable to add users")
     }
   }
}
