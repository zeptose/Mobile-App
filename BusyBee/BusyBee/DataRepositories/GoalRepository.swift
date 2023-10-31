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
          print("Error getting goals: \(error.localizedDescription)" )
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
  
  func create(_ goal: Goal) {
    do {
        let newGoal = goal
        _ = try store.collection(path).addDocument(from: newGoal)
      } catch {
        fatalError("Unable to add goal: \(error.localizedDescription).")
      }
  }
  
  func update(_ goal: Goal) {
    guard let goalId = goal.id else { return }
    
    do {
      try store.collection(path).document(goalId).setData(from: goal)
    } catch {
      fatalError("Unable to update goal: \(error.localizedDescription).")
    }
  }

  func delete(_ goal: Goal) {
    guard let goalId = goal.id else { return }
    
    store.collection(path).document(goalId).delete { error in
      if let error = error {
        print("Unable to remove goal: \(error.localizedDescription)")
      }
    }
  }
  
//  // MARK: Filtering methods
//  func getGoalsFor(_ user: User) -> [Goal] {
//    return self.goals.filter{$0.user == user}
//  }
}
