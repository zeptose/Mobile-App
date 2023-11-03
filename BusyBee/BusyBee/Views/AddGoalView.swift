//
//  AddGoalView.swift
//  BusyBee
//
//  Created by Joshua Yu  on 11/3/23.
//
import SwiftUI

struct AddGoalView: View {
  @ObservedObject var goalController: GoalController
      @State private var newGoalName = ""
      @Environment(\.presentationMode) var presentationMode
      var user: User

      var body: some View {
          VStack {
              TextField("Enter goal name", text: $newGoalName)
                  .padding()
              
              Button("Add Goal") {
                  // Create a new goal and add it using the GoalController, passing the 'user'
                  goalController.addnewGoal(currentUser: user, name: newGoalName, desc: nil, dueDate: Date(), frequency: 1, subGoalStr: [])
                  presentationMode.wrappedValue.dismiss()
              }
              .padding()
          }
      }
  }
