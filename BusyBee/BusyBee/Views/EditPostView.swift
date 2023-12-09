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
      
      @State private var isShowingGoal = false
      @State private var isShowingSubgoal = false
      
      
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
            
//            if !isShowingGoalList{
//              Button(goalController.getGoalFromId(goalId: selectedGoal)!.name) {
//                isShowingGoalList = true
//              }
//            } else {
              HStack {
                Menu {
                  ForEach(goalController.getCurrentGoals(currentUser: currUser)) { goal in
                    Button(goal.name) {
                      selectedGoal = goal.id
                      selectedSubgoal = nil
                      isShowingSubgoal = false
                      isShowingGoal = true
                    }
                  }} label: {
                    Text("Edit Goal")
                      .foregroundColor(.white)
                      .background(
                        RoundedRectangle(cornerRadius: 10)
                           .fill(Color(UIColor(hex: "#FFD111")))
                           .frame(width: 100, height: 30)
                      )
                  }
                  .padding()
                Spacer()
                if isShowingGoal {
                  Text("Selected Goal: \(goalController.getGoalFromId(goalId: selectedGoal)!.name)")
                    .padding()
                }
              }
//            }
            Text("Subgoal").font(.headline)
            Text("Change the subgoal you want your post to be associated with").font(.subheadline).foregroundColor(.gray)
            HStack {
              Menu {
                ForEach(goalController.getSubgoalsForGoal(goal: goalController.getGoalFromId(goalId: selectedGoal)!)) { subgoal in
                  Button(subgoal.name) {
                    selectedSubgoal = subgoal.id!
                    isShowingSubgoal = true
                  }
                }} label: {
                  Text("Edit Subgoal")
                    .foregroundColor(.white)
                    .background(
                      RoundedRectangle(cornerRadius: 10)
                          .fill(Color(UIColor(hex: "#FFD111")))
                          .frame(width: 140, height: 30)
                    )
                }
                .padding()
              Spacer()
              if isShowingSubgoal {
                if let temp = selectedSubgoal {
                  Text("Selected Goal: \(goalController.getSubgoalFromId(subgoalId: temp)!.name)")
                    .padding()
                }
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

