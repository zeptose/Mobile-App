//
//  AddGoalView.swift
//  BusyBee
//
//  Created by Joshua Yu  on 11/3/23.
//
import SwiftUI

struct AddGoalView: View {
  @ObservedObject var goalController: GoalController
  @State private var goalName = ""
  @State private var goalDescription = ""
  @State private var dueDate = Date()
  @State private var frequency = 1
  var user: User
  @Environment(\.presentationMode) var presentationMode

  var body: some View {
      Form {
          Section(header: Text("Goal Details")) {
              TextField("Enter goal name", text: $goalName)
              TextField("Enter description", text: $goalDescription)
              DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
              Stepper(value: $frequency, in: 1...30) {
                  Text("Frequency: \(frequency)")
              }
          }

          Button("Add Goal") {
              // Create a new goal and add it using the GoalController, using the input values
              goalController.addnewGoal(currentUser: user, name: goalName, desc: goalDescription, dueDate: dueDate, frequency: frequency, subGoalStr: [])
              presentationMode.wrappedValue.dismiss()
          }
      }
      .navigationBarTitle("Add Goal")
  }
}

