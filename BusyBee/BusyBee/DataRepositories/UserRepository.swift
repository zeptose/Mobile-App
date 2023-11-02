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

//  func get() {
//    store.collection(path)
//      .addSnapshotListener { querySnapshot, error in
//        if let error = error {
//          print("Error getting users: \(error.localizedDescription)")
//          return
//        }
//        querySnapshot?.documents.forEach({ document in
//          print(document.data())
//        })
//        self.users = querySnapshot?.documents.compactMap { document in
//          try? document.data(as: User.self)
//        } ?? []
//      }
//  }
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

