//
//  EditPostView.swift
//  BusyBee
//
//  Created by elaine wang on 12/7/23.
//

import SwiftUI

struct EditPostView: View {
    @EnvironmentObject var postController: PostController
    @EnvironmentObject var goalController: GoalController
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var userController: UserController
      @Environment(\.presentationMode) var presentationMode
      var currentUser: User
      var postToEdit: Post
      
      @State private var scrollToBottom = false
      @State private var postCaption: String
      
      @State private var selectedGoal: String
      @State private var selectedSubgoal: String?

      init(currentUser: User, post: Post) {
          self.currentUser = currentUser
          self.postToEdit = post

          // Initialize states with the existing goal data
          _postCaption = State(initialValue: post.caption)
          _selectedGoal = State(initialValue: post.goalId)
          _selectedSubgoal = State(initialValue: post.subgoalId!)
      }

      var body: some View {
        if let currUser = viewModel.currentUser {
          VStack(alignment: .leading){
            Text("Caption").font(Font.custom("Quicksand-Bold", size: 20))
            TextField("Change your caption!", text: $postCaption)
                .padding(10)
                .background(
                      RoundedRectangle(cornerRadius: 15)
                          .strokeBorder(Color(UIColor(hex: "#9DB2CE")), lineWidth: 2)
                      )
                .padding(.bottom, 20)
            
            HStack {
              Text("Goal").font(Font.custom("Quicksand-Bold", size: 20))
              Spacer()
              Menu {
                ForEach(goalController.getCurrentGoals(currentUser: currUser)) { goal in
                  Button(goal.name) {
                    selectedGoal = goal.id
                    selectedSubgoal = nil
                  }
                }} label: {
                  Text("Edit Goal")
                    .foregroundColor(Color(UIColor(hex: "#992409")))
                }
            }.padding(.bottom, 12)
            HStack {
              Spacer()
              Text(goalController.getGoalFromId(goalId: selectedGoal)!.name)
                .frame(alignment: .center)
                .background(
                  RoundedRectangle(cornerRadius: 10)
                     .fill(Color(UIColor(hex: "#FFD111")))
                     .frame(width: UIScreen.main.bounds.width * 0.8, height: 30, alignment: .center)
                )
              Spacer()
            }.padding(.bottom, 20)
            
            HStack {
              Text("Subgoal").font(Font.custom("Quicksand-Bold", size: 20))
              Spacer()
              Menu {
                ForEach(goalController.getSubgoalsForGoal(goal: goalController.getGoalFromId(goalId: selectedGoal)!)) { subgoal in
                  Button(subgoal.name) {
                    selectedSubgoal = subgoal.id!
                  }
                }} label: {
                  Text("Edit Subgoal")
                    .foregroundColor(Color(UIColor(hex: "#992409")))

                }
            }.padding(.bottom, 12)
            HStack {
              Spacer()
              if let temp = selectedSubgoal {
                Text(goalController.getSubgoalFromId(subgoalId: temp)!.name)
                  .frame(alignment: .center)
                  .background(
                    RoundedRectangle(cornerRadius: 10)
                      .fill(Color(UIColor(hex: "#FFD111")))
                      .frame(width: UIScreen.main.bounds.width * 0.8, height: 30, alignment: .center)
                  )
              }
              Spacer()
            }
          Spacer()
        }.padding(20)
            .navigationBarTitle("Edit Post")
            .navigationBarItems(trailing:
              Button {
                Task {
                    postController.updatePost(post: postToEdit, caption: postCaption, goalId: selectedGoal, subgoalId: selectedSubgoal)
                  presentationMode.wrappedValue.dismiss()
                }
            } label: {
              Text("Save")
                .bold()
                .foregroundColor(Color(UIColor(hex: "#992409")))
            })
        }
          
      }
}
