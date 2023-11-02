//
//  GoalController.swift
//  BusyBee
//
//  Created by elaine wang on 11/1/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class GoalController: ObservableObject {
  @Published var goalRepository: GoalRepository = GoalRepository()
  
  func addnewGoal(username: String, password: String, bio: String?) {
    
    
  }
}
