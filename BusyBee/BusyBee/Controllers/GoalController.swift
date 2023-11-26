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
    @Published var subgoalRepository: SubgoalRepository = SubgoalRepository()
    @Published var userRepository: UserRepository = UserRepository()
    @Published var goals: [Goal] = []
    @Published var subgoals: [Subgoal] = []
  
    init () {
      self.goalRepository.get({(goals) -> Void in
            self.goals = goals
      })
      
      self.subgoalRepository.get({(subgoals) -> Void in
            self.subgoals = subgoals
      })
    }
  

    func addnewGoal(currentUser: User, name: String, desc: String?, dueDate: Date, frequency: Int, subGoalStr: [String]) async throws {
        let id = UUID().uuidString
        let newGoal = Goal(id: id,
                           name: name,
                           description: desc,
                           dueDate: dueDate,
                           frequency: frequency,
                           userId: currentUser.id,
                           progress: 0)
        try await goalRepository.create(newGoal)
        
        var user = currentUser
        user.goals.append(newGoal)
        userRepository.update(user)
        
        for subgoal in subGoalStr {
            if !subgoal.isEmpty {
                let newSub = Subgoal(name: subgoal,
                                     isCompleted: false,
                                     goalId: newGoal.id)
                subgoalRepository.create(newSub)
            }
        }
    }
  
  func updateGoal(currentUser: User, goal: Goal, newName: String, newDesc: String?, newDueDate: Date, newFrequency: Int, newSubGoals: [String]) async throws {
      // Create a new instance of the goal with updated values
      var updatedGoal = goal
      updatedGoal.name = newName
      updatedGoal.description = newDesc
      updatedGoal.dueDate = newDueDate
      updatedGoal.frequency = newFrequency
      
      // Update the goal in the repository
      try await goalRepository.update(updatedGoal)
      
      // Fetch existing subgoals associated with this goal
    let existingSubgoals = getSubgoalsForGoal(goal: goal)
      
      // Delete existing subgoals
      for subgoal in existingSubgoals {
          subgoalRepository.delete(subgoal)
      }
      
      // Create new subgoals
      for subgoal in newSubGoals {
          if !subgoal.isEmpty {
              let newSub = Subgoal(name: subgoal, isCompleted: false, goalId: updatedGoal.id)
              subgoalRepository.create(newSub)
          }
      }
      
      // Assuming the goal is associated with the current user, update the user's goals
      var user = currentUser
      if let index = user.goals.firstIndex(where: { $0.id == goal.id }) {
          user.goals[index] = updatedGoal
          userRepository.update(user)
      }
  }


  
    func getCurrentGoals(currentUser: User) -> [Goal] {
      let usersGoals = self.goals.filter{ String($0.userId) == String(currentUser.id) }
      let today = Date()
      let curr = usersGoals.filter { today <= $0.dueDate && $0.progress < $0.frequency }
//      print("currentUser: \(currentUser)" )
//      print("currentGoals: \(curr)")
      return curr.sorted { $0.dueDate >= $1.dueDate}
      
    }
  
    func getPastGoals(currentUser: User) -> [Goal] {
        let usersGoals = self.goals.filter{ String($0.userId) == String(currentUser.id) }
        let today = Date()
        let past = usersGoals.filter { $0.progress == $0.frequency || today > $0.dueDate}
        return past.sorted { $0.dueDate >= $1.dueDate}
    }
  
    func getSubgoalsForGoal(goal: Goal) -> [Subgoal] {
      return self.subgoals.filter( {$0.goalId == goal.id} )
    }
    
    func getSubgoalFromId(subgoalId: String) -> Subgoal?  {
        let temp = self.subgoals.first( where: {$0.id == subgoalId} )
        if let ourSubgoal = temp {
          return ourSubgoal
        } else {
          return nil
        }
    }
  
    func getGoalFromId(goalId: String) -> Goal? {
      let temp = self.goals.first( where: {$0.id == goalId} )
      if let ourGoal = temp {
        return ourGoal
      } else {
        return nil
      }
    }

}
