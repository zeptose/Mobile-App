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
  @State private var subgoalName = ""
  @State private var subgoals: [String] = [""]
  var user: User
  @Environment(\.presentationMode) var presentationMode

  var body: some View {
      Form {
          Section(header: Text("Goal Details")) {
              TextField("Enter Goal Name", text: $goalName)
              TextField("Enter Description", text: $goalDescription)
              DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
              Stepper(value: $frequency, in: 1...30) {
                  Text("Frequency: \(frequency)")
              }
          }
          Section(header: Text("Milestones")) {
              VStack {
                  ScrollView {
                      ForEach(subgoals.indices, id: \.self) { index in
                          TextField("Enter Milestone", text: $subgoals[index])
                              .autocapitalization(.words)
                              .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                              .lineLimit(1)
                      }
                  }
                  
                  Button {
                      subgoals.append("")
                  } label: {
                      HStack {
                          Image(systemName: "plus")
                              .foregroundColor(.white)
                          Text("Add Milestone")
                              .font(.subheadline)
                              .foregroundColor(.white)
                      }
                      .padding(8)
                      .background(Color(UIColor(hex: "#992409"))).opacity(1)
                      .clipShape(Capsule())
                  }
              }
              
          }
      }
      Button("Add Goal") {
        Task {
          // Create a new goal and add it using the GoalController, using the input values
          try await goalController.addnewGoal(currentUser: user, name: goalName, desc: goalDescription, dueDate: dueDate, frequency: frequency, subGoalStr: subgoals)
          presentationMode.wrappedValue.dismiss()
        }
      }
      .navigationBarTitle("Add Goal")
  }
}

