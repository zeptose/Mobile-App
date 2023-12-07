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

      @State private var isShowingSubgoalList = false
      @State private var selectedGoal: String
      @State private var selectedSubgoal: String
//      var selectedGoal: Goal? {
//        guard selectedGoalIndex >= 0 else{
//          return nil
//        }
//        return goalController.getCurrentGoals(currentUser: viewModel.currentUser!)[selectedGoalIndex]
//      }
//      
//      var selectedSubgoal: Subgoal? {
//        guard selectedSubgoalIndex >= 0 else {
//          return nil
//        }
//        return goalController.getSubgoalsForGoal(goal: selectedGoal!)[selectedSubgoalIndex]
//      }
//  
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
            Text("Caption").font(.headline)
//            Text("Change your caption!").font(.subheadline).foregroundColor(.gray)
            TextField("Change your caption!", text: $postCaption)
                .padding(10)
                .background(
                      RoundedRectangle(cornerRadius: 15)

                              .strokeBorder(Color(UIColor(hex: "#9DB2CE")), lineWidth: 2)
                      )
            Text("Goal").font(.headline)
            Text("Change the goal you want your post to be associated with").font(.subheadline).foregroundColor(.gray)
            VStack {
              Menu {
                ForEach(goalController.getCurrentGoals(currentUser: currUser)) { goal in
                  Button(goal.name) {
                    selectedGoal = goal.id
                    isShowingSubgoalList = true
                  }
                }} label: {
                  Text(goalController.getGoalFromId(goalId: selectedGoal)!.name)
                }
                .padding()
                .offset(y: -5)
            }
            if isShowingSubgoalList {
              VStack {
                Menu {
                  ForEach(goalController.getSubgoalsForGoal(goal: goalController.getGoalFromId(goalId: selectedGoal)!)) { subgoal in
                    Button(subgoal.name) {
                      selectedSubgoal = subgoal.id!
                    }
                  }} label: {
                    Text(goalController.getSubgoalFromId(subgoalId: selectedSubgoal)!.name)
                  }
                  .padding()
                  .offset(y: -5)
                }
              }
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
                    .foregroundColor(Color(UIColor(hex: "#992409")))})
        }
          
      }
}

