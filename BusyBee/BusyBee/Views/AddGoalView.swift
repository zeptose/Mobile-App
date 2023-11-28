//
//  AddGoalView.swift
//  BusyBee
//
//  Created by Joshua Yu  on 11/3/23.
//
//import SwiftUI
//
//struct AddGoalView: View {
//  @ObservedObject var goalController: GoalController
//  @State private var goalName = ""
//  @State private var goalDescription = ""
//  @State private var dueDate = Date()
//  @State private var frequency = ""
//  @State private var subgoalName = ""
//  @State private var subgoals: [String] = [""]
//  @State private var isDatePickerPresented = false
//  var user: User
//  @Environment(\.presentationMode) var presentationMode
//
//  var body: some View {
//      VStack(alignment: .leading){
//          Text("Goal Name").font(.headline)
//          Text("Give your goal a name!").font(.subheadline).foregroundColor(.gray)
//          TextField("Enter Goal Name", text: $goalName)
//              .padding(10)
//              .background(
//                    RoundedRectangle(cornerRadius: 15)
//
//                            .strokeBorder(Color(UIColor(hex: "#9DB2CE")), lineWidth: 2)
//                    )
//          Text("Description").font(.headline)
//          Text("Describe what you want your goal to be!").font(.subheadline).foregroundColor(.gray)
//          TextField("Enter Description", text: $goalDescription)
//              .padding(10)
//              .background(
//                    RoundedRectangle(cornerRadius: 15)
//
//                            .strokeBorder(Color(UIColor(hex: "#9DB2CE")), lineWidth: 2)
//                    )
//          Text("Due Date").font(.headline)
//          Text("When do you want this goal to be completed?").font(.subheadline).foregroundColor(.gray)
//          DatePicker("", selection: $dueDate, displayedComponents: .date)
//              .labelsHidden()
//              .padding(10)
//              .frame(maxWidth: .infinity, alignment: .leading)
//              .background(
//                    RoundedRectangle(cornerRadius: 15)
//
//                            .strokeBorder(Color(UIColor(hex: "#9DB2CE")), lineWidth: 2)
//                    )
//
//          Text("Frequency").font(.headline)
//          Text("How often do you want to update progress on your goal?").font(.subheadline).foregroundColor(.gray)
//          TextField("Enter Frequency", text: $frequency)
//              .keyboardType(.numberPad)
//              .padding(10)
//              .background(
//                    RoundedRectangle(cornerRadius: 15)
//
//                            .strokeBorder(Color(UIColor(hex: "#9DB2CE")), lineWidth: 2)
//                    )
//          Text("Milestones").font(.headline)
//          Text("Add smaller goals that will serve as intermediary steps on your road to your main goal!").font(.subheadline).foregroundColor(.gray)
//              VStack {
//                  ScrollView {
//                      ForEach(subgoals.indices, id: \.self) { index in
//                              HStack {
//                                  TextField("Enter Milestone", text: $subgoals[index])
//                                      .autocapitalization(.words)
//                                      .padding(.leading, 10)
//                                      .padding(.vertical, 5)
//                                      .lineLimit(1)
//                                      .background(
//                                            RoundedRectangle(cornerRadius: 15)
//                                                .fill(Color(UIColor(hex: "#E0E0E0")))
//                                            )
//                                      .padding(5)
//                                  Button(action: {
//                                      subgoals.remove(at: index)
//                                  }) {
//                                      Image(systemName: "minus")
//                                          .foregroundColor(Color(UIColor(hex: "#992409")))
//                                  }
//                              }
//
//                          }
//                  }
//                  Button {
//                      subgoals.append("")
//                  } label: {
//                      HStack {
//                          Image(systemName: "plus")
//                              .foregroundColor(.white)
//                          Text("Add Milestone")
//                              .font(.subheadline)
//                              .foregroundColor(.white)
//                      }
//                      .padding(8)
//                      .background(Color(UIColor(hex: "#992409"))).opacity(1)
//                      .clipShape(Capsule())
//                  }
//              }
//      }.padding(20)
//          .navigationBarTitle("New Goal")
//          .navigationBarItems(trailing:
//            Button {
//              Task {
//                  try await goalController.addnewGoal(currentUser: user, name: goalName, desc: goalDescription, dueDate: dueDate, frequency: Int(frequency) ?? 1, subGoalStr: subgoals)
//                presentationMode.wrappedValue.dismiss()
//              }
//          } label: {
//              Text("Add Goal")
//                  .bold()
//                  .foregroundColor(Color(UIColor(hex: "#992409")))})
//
//  }
//}

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
