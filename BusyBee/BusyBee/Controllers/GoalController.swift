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
  
    func addnewGoal(currentUser: User, name: String, desc: String?, dueDate: Date, frequency: Int, subGoalStr: [String]) {
//        let id = UUID().uuidString
        var subgoalsForGoal : [Subgoal] = []
        for subgoal in subGoalStr {
            if !subgoal.isEmpty {
                let newSub = Subgoal(name: subgoal,
                                     isCompleted: false)
                subgoalRepository.create(newSub)
                subgoals.append(newSub)
                subgoalsForGoal.append(newSub)
            }
        }
        let newGoal = Goal(name: name,
                           description: desc,
                           dueDate: dueDate,
                           frequency: frequency,
                           subgoals: subgoalsForGoal,
                           userId: currentUser.id,
                           progress: 0)
        goalRepository.create(newGoal)
        var user = currentUser
        user.goals.append(newGoal)
        userRepository.update(user)
    }
  
    func getCurrentGoals(currentUser: User) -> [Goal] {
      let usersGoals = self.goals.filter{ String($0.userId) == String(currentUser.id) }
      let today = Date()
      let curr = usersGoals.filter { today <= $0.dueDate }
      return curr.sorted { $0.dueDate >= $1.dueDate}
    }
  
    func getPastGoals(currentUser: User) -> [Goal] {
        let usersGoals = self.goals.filter{ String($0.userId) == String(currentUser.id) }
        let today = Date()
        let curr = usersGoals.filter { today > $0.dueDate }
        return curr.sorted { $0.dueDate >= $1.dueDate}
    }
  
    func getSubgoals(currentUser: User, goal: Goal) -> [Subgoal] {
        return goal.subgoals
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
