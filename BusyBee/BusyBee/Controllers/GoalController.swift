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
  
    init () {
      self.goalRepository.get({(goals) -> Void in
            self.goals = goals
      })
    }
  
    func addnewGoal(currentUser: User, name: String, desc: String?, dueDate: Date, frequency: Int, subGoalStr: [String]) {
//        let id = UUID().uuidString
        var subgoals: [Subgoal] = []
        for subgoal in subGoalStr {
            let newSub = Subgoal(name: subgoal,
                                 isCompleted: false)
            subgoalRepository.create(newSub)
            subgoals.append(newSub)
        }
        let newGoal = Goal(name: name,
                           description: desc,
                           dueDate: dueDate,
                           frequency: frequency,
                           subgoals: subgoals,
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
    
}
