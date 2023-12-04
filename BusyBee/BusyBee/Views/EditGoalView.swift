//
//  EditGoalView.swift
//  BusyBee
//
//  Created by Ryan McGrady on 11/20/23.
//

import SwiftUI

struct EditGoalView: View {
    @ObservedObject var goalController: GoalController
    @Environment(\.presentationMode) var presentationMode
    var currentUser: User
    var goalToEdit: Goal

    @State private var goalName: String
    @State private var goalDescription: String?
    @State private var dueDate: Date
    @State private var frequency: String
    @State private var subgoals: [Subgoal]

    init(goalController: GoalController, currentUser: User, goal: Goal) {
        self.goalController = goalController
        self.currentUser = currentUser
        self.goalToEdit = goal

        // Initialize states with the existing goal data
        _goalName = State(initialValue: goal.name)
        _goalDescription = State(initialValue: goal.description ?? "")
        _dueDate = State(initialValue: goal.dueDate)
        _frequency = State(initialValue: "\(goal.frequency)")
        _subgoals = State(initialValue: goalController.getSubgoalsForGoal(goal: goal))
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Goal Name").font(.headline)
            TextField("Enter Goal Name", text: $goalName)
                .padding(10)

            Text("Description").font(.headline)
            TextField("Enter Description", text: Binding(
                get: { goalDescription ?? "" },
                set: { goalDescription = $0 }
            ))
            .padding(10)

            Text("Due Date").font(.headline)
            DatePicker("Select Due Date", selection: $dueDate, displayedComponents: .date)
                .padding(10)

            Text("Frequency").font(.headline)
            TextField("Enter Frequency", text: $frequency)
                .keyboardType(.numberPad)
                .padding(10)

          Text("Milestones").font(.headline)
          
          ForEach($subgoals) { $subgoal in
              TextField("Enter Subgoal Name", text: $subgoal.name)
                  .padding(10)
          }

            Button("Save Changes") {
                Task {
                    try await goalController.updateGoal(
                        currentUser: currentUser,
                        goal: goalToEdit,
                        newName: goalName,
                        newDesc: goalDescription,
                        newDueDate: dueDate,
                        newFrequency: Int(frequency) ?? 1,
                        newSubGoals: subgoals.map{ $0.name }
                    )
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .padding(20)
        .navigationBarTitle("Edit Goal")
    }
}
