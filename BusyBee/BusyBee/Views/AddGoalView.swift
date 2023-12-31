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
    @State private var showAlert = false
    var user: User
    @Environment(\.presentationMode) var presentationMode
    @State private var currentStep = 0
    let textPadding = EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0)
    let fieldPadding = EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
    let hivePadding = EdgeInsets(top: 7, leading: 0, bottom: 10, trailing: 57)
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if currentStep == 0 {
                    VStack {
                        Image("AddGoalHive0")
                            .padding(10)
                        Text("Create a new goal to fill up the hive!").font(Font.custom("Quicksand-Bold", size: 20))
                    }
                        
                }
                else if currentStep == 1 {
                        HStack {
                            Spacer()
                            Image("AddGoalHive1")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 220, height: 220, alignment: .center)
                                .padding(10)
                            Spacer()
                        }
                        Text("Goal Name").font(Font.custom("Quicksand-Bold", size: 20)).padding(textPadding)
                        Text("Give your goal a name!").font(Font.custom("Quicksand-Regular", size: 16)).foregroundColor(.gray).padding(textPadding)
                        TextField("Enter Goal Name", text: $goalName)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                
                                    .strokeBorder(Color(UIColor(hex: "#9DB2CE")), lineWidth: 2)
                            ).padding(fieldPadding)
                    Spacer()

                } else if currentStep == 2 {
                    HStack {
                        Spacer()
                        Image("AddGoalHive2")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 225, height: 225)
                            .padding(hivePadding)
                        Spacer()
                    }
                    Text("Description").font(Font.custom("Quicksand-Bold", size: 20)).padding(textPadding)
                    Text("Describe what you want your goal to be!").font(Font.custom("Quicksand-Regular", size: 16)).foregroundColor(.gray).padding(textPadding)
                    TextField("Enter Description", text: $goalDescription)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                            
                                .strokeBorder(Color(UIColor(hex: "#9DB2CE")), lineWidth: 2)
                        ).padding(fieldPadding)
                    Spacer()
                    
                } else if currentStep == 3 {
                   
                    HStack {
                        Spacer()
                        Image("AddGoalHive3")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 225, height: 225)
                            .padding(hivePadding)
                        Spacer()
                    }
                    Text("Due Date").font(Font.custom("Quicksand-Bold", size: 20)).padding(textPadding)
                    Text("When do you want this goal to be completed?").font(Font.custom("Quicksand-Regular", size: 16)).foregroundColor(.gray).padding(textPadding)
                    DatePicker("", selection: $dueDate, displayedComponents: .date)
                        .labelsHidden()
                        .padding(10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                            
                                .strokeBorder(Color(UIColor(hex: "#9DB2CE")), lineWidth: 2)
                        ).padding(fieldPadding)
                    Spacer()
                    
                } else if currentStep == 4 {
                    HStack {
                        Spacer()
                        Image("AddGoalHive4")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 240, height: 240)
                            .padding(EdgeInsets(top: -3, leading: 0, bottom: 0, trailing: 8))
                        Spacer()
                    }
                        .padding(10)
                    Text("Frequency").font(Font.custom("Quicksand-Bold", size: 20)).padding(textPadding)
                    Text("How many posts do you want to make to reach your goal?").font(Font.custom("Quicksand-Regular", size: 16)).foregroundColor(.gray).padding(textPadding)
                    TextField("Enter Frequency", text: $frequency)
                    
                        .keyboardType(.numberPad)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                            
                                .strokeBorder(Color(UIColor(hex: "#9DB2CE")), lineWidth: 2)
                        ).padding(fieldPadding)
                        .onChange(of: frequency) { newValue in
                            if let enteredValue = Int(newValue), enteredValue <= 0 {
                                self.showAlert = true
                            }
                        }
                    Spacer()
                    
                } else if currentStep == 5 {
                    HStack {
                        Spacer()
                        Image("AddGoalHive5")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 310, height: 200, alignment: .center)
                            .padding(EdgeInsets(top: 27, leading: 0, bottom: 30, trailing: 6))
                        Spacer()
                    }
                        Text("Milestones").font(Font.custom("Quicksand-Bold", size: 20)).padding(textPadding)
                        Text("Add smaller steps that you want to take to reach your goal!").font(Font.custom("Quicksand-Regular", size: 16)).foregroundColor(.gray).padding(textPadding)
                        VStack {
                            ScrollView {
                              VStack{
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
                                        .padding(10)
                                      Button(action: {
                                        subgoals.remove(at: index)
                                      }) {
                                        Image(systemName: "xmark")
                                          .foregroundColor(Color(UIColor(hex: "#000000")))
                                          .padding(.trailing, 10)
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
                                      .foregroundColor(.gray)
                                      Text("Add Milestone")
                                          .font(Font.custom("Quicksand-Regular", size: 16))
                                          .foregroundColor(.gray)
                                  }
                                  .padding(8)
                                  .background(Color(UIColor(hex: "#E0E0E0"))).opacity(1)
                                  .cornerRadius(8)
                                  .padding(.leading, 10)
                                  .padding(.vertical, 5)

                              }
                            }
                            
                        }
                    }
               
                
              HStack {
                  if currentStep > 0 {
                      Button(action: {
                          withAnimation {
                              currentStep -= 1
                          }
                      }) {
                          HStack {
                              Image(systemName: "chevron.left")
                              Text("Previous")
                          }
                          .padding(.vertical, 10)
                          .padding(.horizontal, 16)
                          .foregroundColor(Color(UIColor(hex: "#992409")))
                      }
                      .padding(.leading, 32)
                      .padding(.bottom, 10)
                  }
                  
                  Spacer()
                  
                  if currentStep < 5 {
                      Button(action: {
                          withAnimation {
                              if currentStep < 5 {
                                  currentStep += 1
                              }
                          }
                      }) {
                          HStack {
                              Text("Next")
                              Image(systemName: "chevron.right")
                          }
                          .padding(.vertical, 10)
                          .padding(.horizontal, 16)
                          .foregroundColor(.white)
                          .background(Color(UIColor(hex: "#992409")))
                          .cornerRadius(8)
                      }
                      .padding(.leading, 8)
                      .padding(.trailing, 32)
                  } else {
                      Button(action: {
                          Task {
                              try await goalController.addnewGoal(currentUser: user, name: goalName, desc: goalDescription, dueDate: dueDate, frequency: Int(frequency) ?? 1, subGoalStr: subgoals)
                              presentationMode.wrappedValue.dismiss()
                          }
                      }) {
                          HStack {
                              Text("Confirm")
                              Image(systemName: "checkmark")
                          }
                          .padding(.vertical, 10)
                          .padding(.horizontal, 16)
                          .foregroundColor(.white)
                          .background(Color(UIColor(hex: "#992409")))
                          .cornerRadius(8)
                      }
                      .padding(.leading, 8)
                      .padding(.trailing, 32)
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
