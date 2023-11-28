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
    @State private var frequency = ""
    @State private var subgoalName = ""
    @State private var subgoals: [String] = [""]
    @State private var isDatePickerPresented = false
    @State private var scrollToBottom = false
    var user: User
    @Environment(\.presentationMode) var presentationMode
    @State private var currentStep = 0
   
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if currentStep == 0 {
                    Text("Let's set a goal! (placeholder)")
                        
                }
                else if currentStep == 1 {
                    Text("Goal Name").font(.headline)
                    Text("Give your goal a name!").font(.subheadline).foregroundColor(.gray)
                    TextField("Enter Goal Name", text: $goalName)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                            
                                .strokeBorder(Color(UIColor(hex: "#9DB2CE")), lineWidth: 2)
                        )
                } else if currentStep == 2 {
                    Text("Description").font(.headline)
                    Text("Describe what you want your goal to be!").font(.subheadline).foregroundColor(.gray)
                    TextField("Enter Description", text: $goalDescription)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                            
                                .strokeBorder(Color(UIColor(hex: "#9DB2CE")), lineWidth: 2)
                        )
                } else if currentStep == 3 {
                    Text("Due Date").font(.headline)
                    Text("When do you want this goal to be completed?").font(.subheadline).foregroundColor(.gray)
                    DatePicker("", selection: $dueDate, displayedComponents: .date)
                        .labelsHidden()
                        .padding(10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                            
                                .strokeBorder(Color(UIColor(hex: "#9DB2CE")), lineWidth: 2)
                        )
                } else if currentStep == 4 {
                    Text("Frequency").font(.headline)
                    Text("How often do you want to update progress on your goal?").font(.subheadline).foregroundColor(.gray)
                    TextField("Enter Frequency", text: $frequency)
                        .keyboardType(.numberPad)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                            
                                .strokeBorder(Color(UIColor(hex: "#9DB2CE")), lineWidth: 2)
                        )
                } else if currentStep == 5 {
                    Text("Milestones").font(.headline)
                    Text("Add smaller goals that will serve as intermediary steps on your road to your main goal!").font(.subheadline).foregroundColor(.gray)
                    VStack {
                       ScrollView {
                           ScrollViewReader { scrollView in
                               ForEach(subgoals.indices, id: \.self) { index in
                                   HStack {
                                       TextField("Enter Milestone", text: $subgoals[index])
                                           .autocapitalization(.words)
                                           .padding(.leading, 10)
                                           .padding(.vertical, 5)
                                           .lineLimit(1)
                                           .background(
                                               RoundedRectangle(cornerRadius: 15)
                                                   .fill(Color(UIColor(hex: "#E0E0E0")))
                                           )
                                           .padding(5)
                                       Button(action: {
                                           subgoals.remove(at: index)
                                       }) {
                                           Image(systemName: "minus")
                                               .foregroundColor(Color(UIColor(hex: "#992409")))
                                       }
                                   }
                               }
                               .onChange(of: subgoals.count) { _ in
                                   if scrollToBottom {
                                       withAnimation {
                                           scrollView.scrollTo(subgoals.count - 1, anchor: .bottom)
                                       }
                                       scrollToBottom = false
                                   }
                               }
                           }
                       }
                       Button {
                           subgoals.append("")
                           scrollToBottom = true
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
                
                HStack {
                   
                    if currentStep > 0 {
                        Button("Previous") {
                            withAnimation {
                                currentStep -= 1
                            }
                        }
                        .padding()
                        .foregroundColor(Color(UIColor(hex: "#992409")))
                    }
                    Spacer()
                    if currentStep < 5 {
                        Button("Next") {
                            withAnimation {
                                if currentStep < 5 {
                                    currentStep += 1
                                }
                            }
                        }
                        .padding()
                        .foregroundColor(Color(UIColor(hex: "#992409")))
                    } else {
                        Button {
                            Task {
                                try await goalController.addnewGoal(currentUser: user, name: goalName, desc: goalDescription, dueDate: dueDate, frequency: Int(frequency) ?? 1, subGoalStr: subgoals)
                                presentationMode.wrappedValue.dismiss()
                            }
                        } label: {
                            Text("Add Goal")
                                .bold()
                                .foregroundColor(Color(UIColor(hex: "#992409")))
                        }.padding()
                    }
                }
            }
        }.navigationBarTitle("New Goal")
    }
}


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
