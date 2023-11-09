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
    self.get({ (goals) -> Void in
          self.goals = goals
        })
  }

  func get(_ completionHandler: @escaping (_ goals: [Goal]) -> Void) {
      store.collection(path)
        .addSnapshotListener { querySnapshot, error in
          if let error = error {
            print("Error getting goals: \(error.localizedDescription)")
            return
          }
          
          let goals = querySnapshot?.documents.compactMap { document in
            try? document.data(as: Goal.self)
          } ?? []
          completionHandler(goals)
        }
  }
  
  func create(_ goal: Goal) async throws {
    do {
//        let newGoal = goal
//        _ = try store.collection(path).addDocument(from: newGoal)
        let encodedGoal = try Firestore.Encoder().encode(goal)
        try await store.collection(path).document(goal.id).setData(encodedGoal)

      } catch {
        fatalError("Unable to add goal: \(error.localizedDescription).")
      }
  }
  
  func update(_ goal: Goal) {
    let goalId = goal.id
    
    do {
      try store.collection(path).document(goalId).setData(from: goal)
    } catch {
      fatalError("Unable to update goal: \(error.localizedDescription).")
    }
  }

  func delete(_ goal: Goal) {
   let goalId = goal.id 
    
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
