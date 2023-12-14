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

    @State private var scrollToBottom = false
    @State private var goalName: String
    @State private var goalDescription: String?
    @State private var dueDate: Date
    @State private var frequency: String
    @State private var subgoals: [String]

    init(goalController: GoalController, currentUser: User, goal: Goal) {
        self.goalController = goalController
        self.currentUser = currentUser
        self.goalToEdit = goal

        // Initialize states with the existing goal data
        _goalName = State(initialValue: goal.name)
        _goalDescription = State(initialValue: goal.description ?? "")
        _dueDate = State(initialValue: goal.dueDate)
        _frequency = State(initialValue: "\(goal.frequency)")
        _subgoals = State(initialValue: goalController.getSubgoalNamesForGoal(goal: goal))
    }

    var body: some View {
      
      //delete 39-44 later and uncomment everything else
      VStack {
                  Text("Hello, SwiftUI!")
                      .font(.title)
                      .foregroundColor(.blue)
              }
              .padding()
//      ScrollView {
//        VStack(alignment: .leading){
//          Group{
//            Text("Goal Name").font(.headline)
//            Text("Change your goal name!").font(.subheadline).foregroundColor(.gray)
//            TextField("Enter Goal Name", text: $goalName)
//              .padding(10)
//              .background(
//                RoundedRectangle(cornerRadius: 15)
//
//                  .strokeBorder(Color(UIColor(hex: "#9DB2CE")), lineWidth: 2)
//              )
//            Text("Description").font(.headline)
//            Text("Change your description!").font(.subheadline).foregroundColor(.gray)
//            TextField("Enter Description", text: Binding(
//              get: { goalDescription ?? "" },
//              set: { goalDescription = $0 }
//            ))
//            .padding(10)
//            .background(
//              RoundedRectangle(cornerRadius: 15)
//
//                .strokeBorder(Color(UIColor(hex: "#9DB2CE")), lineWidth: 2)
//            )
//            Text("Due Date").font(.headline)
//            Text("When do you want this goal to be completed?").font(.subheadline).foregroundColor(.gray)
//            DatePicker("", selection: $dueDate, displayedComponents: .date)
//              .labelsHidden()
//              .padding(10)
//              .frame(maxWidth: .infinity, alignment: .leading)
//              .background(
//                RoundedRectangle(cornerRadius: 15)
//
//                  .strokeBorder(Color(UIColor(hex: "#9DB2CE")), lineWidth: 2)
//              )
//
//            Text("Frequency").font(.headline)
//            Text("How many posts do you want to make to reach your goal?").font(.subheadline).foregroundColor(.gray)
//            TextField("Enter Frequency", text: $frequency)
//              .keyboardType(.numberPad)
//              .padding(10)
//              .background(
//                RoundedRectangle(cornerRadius: 15)
//
//                  .strokeBorder(Color(UIColor(hex: "#9DB2CE")), lineWidth: 2)
//              )
//            Text("Milestones").font(.headline)
//            Text("Edit your milestones!").font(.subheadline).foregroundColor(.gray)
//            VStack {
//              ScrollView {
//                ScrollViewReader { scrollView in
//                  ForEach(subgoals.indices, id: \.self) { index in
//                    HStack {
//                      TextField("Enter Milestone", text: $subgoals[index])
//                        .autocapitalization(.words)
//                        .padding(.leading, 10)
//                        .padding(.vertical, 5)
//                        .lineLimit(1)
//                        .background(
//                          RoundedRectangle(cornerRadius: 15)
//                            .fill(Color(UIColor(hex: "#E0E0E0")))
//                        )
//                        .padding(10)
//                      Button(action: {
//                        subgoals.remove(at: index)
//                      }) {
//                        Image(systemName: "minus")
//                          .foregroundColor(Color(UIColor(hex: "#992409")))
//                          .padding(.trailing, 10)
//                      }
//                    }
//                  }
//                  .onChange(of: subgoals.count) { _ in
//                    if scrollToBottom {
//                      withAnimation {
//                        scrollView.scrollTo(subgoals.count - 1, anchor: .bottom)
//                      }
//                      scrollToBottom = false
//                    }
//                  }
//                }
//              }
//              Button {
//                subgoals.append("")
//                scrollToBottom = true
//              } label: {
//                HStack {
//                  Image(systemName: "plus")
//                    .foregroundColor(.white)
//                  Text("Add Milestone")
//                    .font(.subheadline)
//                    .foregroundColor(.white)
//                }
//                .padding(8)
//                .background(Color(UIColor(hex: "#992409"))).opacity(1)
//                .clipShape(Capsule())
//              }
//            }
//
//          }.padding(20)
//            .navigationBarTitle("Edit Goal")
//            .navigationBarItems(trailing:
//                                  Button {
//              Task {
//                try await goalController.updateGoal(
//                  currentUser: currentUser,
//                  goal: goalToEdit,
//                  newName: goalName,
//                  newDesc: goalDescription,
//                  newDueDate: dueDate,
//                  newFrequency: Int(frequency) ?? 1,
//                  newSubGoals: subgoals
//                )
//                presentationMode.wrappedValue.dismiss()
//              }
//            } label: {
//              Text("Save")
//                .bold()
//              .foregroundColor(Color(UIColor(hex: "#992409")))})
//        }
//      }
    }
}


