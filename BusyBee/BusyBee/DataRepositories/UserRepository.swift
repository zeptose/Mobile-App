//
//  UserRepository.swift
//  BusyBee
//
//  Created by elaine wang on 10/31/23.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserRepository: ObservableObject {
  // Set up properties here
  private let store = Firestore.firestore()
  let path = "users"
  
  @Published var users: [User] = []
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    self.get({ (users) -> Void in
          self.users = users
        })
  }

  func getUserWithId(_ userId: String) -> User? {
         // Implement the logic to fetch a user with the given userId
         // This might involve querying a data source or fetching from a stored array of users
         
         // Example (if users are stored in an array):
         return users.first { $0.id == userId }
     }
  func get(_ completionHandler: @escaping (_ users: [User]) -> Void) {
      store.collection(path)
        .addSnapshotListener { querySnapshot, error in
          if let error = error {
            print("Error getting users: \(error.localizedDescription)")
            return
          }
          
          let users = querySnapshot?.documents.compactMap { document in
            try? document.data(as: User.self)
          } ?? []
          completionHandler(users)
        }
    }
  
  func create(_ user: User) {
    do {
        let newUser = user
        _ = try store.collection(path).addDocument(from: newUser)
      } catch {
        fatalError("Unable to add user: \(error.localizedDescription).")
      }
  }
  
  func update(_ user: User) {
//    guard let userId = user.id else { return }
    let userId = user.id
    do {
      try store.collection(path).document(userId).setData(from: user)
    } catch {
      fatalError("Unable to update user: \(error.localizedDescription).")
    }
  }
  
  func refreshFirestoreData() {
          store.collection(path).getDocuments { [weak self] snapshot, error in
              guard let self = self, error == nil else {
                  print("Error refreshing Firestore data: \(error?.localizedDescription ?? "Unknown error")")
                  return
              }

              let refreshedUsers = snapshot?.documents.compactMap { document in
                  try? document.data(as: User.self)
              } ?? []

              // Update the users array with refreshed data
              DispatchQueue.main.async {
                  self.users = refreshedUsers
              }
          }
      }
  

  func delete(_ user: User) {
//    guard let userId = user.id else { return }
    let userId = user.id
    store.collection(path).document(userId).delete { error in
      if let error = error {
        print("Unable to remove user: \(error.localizedDescription)")
      }
    }
  }
}

