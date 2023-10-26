//
//  FirebaseController.swift
//  BusyBee
//
//  Created by elaine wang on 10/25/23.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class GoalRepository: ObservableObject {
  // Set up properties here
  private let store = Firestore.firestore()
  let path = "goals"
  
  @Published var goals: [Goal] = []
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    self.get()
  }

  func get() {
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting goals")
          return
        }
        querySnapshot?.documents.forEach({ document in
          print(document.data())
        })
        print("hi")
        self.goals = querySnapshot?.documents.compactMap { document in
          try? document.data(as: Goal.self)
        } ?? []
      }
  }
}
