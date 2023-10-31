//
//  SubgoalRepository.swift
//  BusyBee
//
//  Created by elaine wang on 10/31/23.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class SubgoalRepository: ObservableObject {
  // Set up properties here
  private let store = Firestore.firestore()
  let path = "subgoals"
  
  @Published var subgoals: [Subgoal] = []
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    self.get()
  }

  func get() {
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting subgoals: \(error.localizedDescription)" )
          return
        }
        querySnapshot?.documents.forEach({ document in
          print(document.data())
        })
        self.subgoals = querySnapshot?.documents.compactMap { document in
          try? document.data(as: Subgoal.self)
        } ?? []
      }
  }
  
  func create(_ subgoal: Subgoal) {
    do {
        let newSubgoal = subgoal
        _ = try store.collection(path).addDocument(from: newSubgoal)
      } catch {
        fatalError("Unable to add subgoal: \(error.localizedDescription).")
      }
  }
  
  func update(_ subgoal: Subgoal) {
    guard let subgoalId = subgoal.id else { return }
    
    do {
      try store.collection(path).document(subgoalId).setData(from: subgoal)
    } catch {
      fatalError("Unable to update subgoal: \(error.localizedDescription).")
    }
  }

  func delete(_ subgoal: Subgoal) {
    guard let subgoalId = subgoal.id else { return }
    
    store.collection(path).document(subgoalId).delete { error in
      if let error = error {
        print("Unable to remove subgoal: \(error.localizedDescription)")
      }
    }
  }
}
