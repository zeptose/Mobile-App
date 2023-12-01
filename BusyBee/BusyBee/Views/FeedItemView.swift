//
//  FeedItemView.swift
//  BusyBee
//
//  Created by elaine wang on 11/7/23.
//

import SwiftUI

struct FeedItemView: View {
    var userId: String
    var post: Post
    @EnvironmentObject var postController: PostController
    @EnvironmentObject var userController: UserController
    @EnvironmentObject var goalController: GoalController
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isShowingPopUp = false
    @State private var isSheetPresented = false
  
    var body: some View {
      if let feedUser = userController.getUserFromId(userId: userId){
        VStack {
          VStack {
            // Profile Picture and Username
            
            HStack {
              Image("profilePic") // Replace with user's profile image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50, alignment: .leading)
                .clipShape(Circle())
              
              Text(feedUser.username)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
          }
          
          // Goal and Progress
          
          if let feedGoal = goalController.getGoalFromId(goalId: post.goalId) {
            let percentage = CGFloat(feedGoal.progress)/CGFloat(feedGoal.frequency)
            let progressBarMax = UIScreen.main.bounds.width - 85
              NavigationLink(destination: IndividualGoalView(goal: feedGoal)) {
//                RoundedRectangle(cornerRadius: 12)
////                  .fill(Color(.clear))
//                  .fill(Color(.blue))
//                  .overlay(
//                    VStack {
//                      HStack{
//                        Text(feedGoal.name)
//                          .font(.subheadline)
//                          .foregroundColor(.black)
//                          .frame(maxWidth: .infinity, alignment: .leading)
//                        //                      .padding(.leading, 10)
//                        Text("\(feedGoal.progress)/\(feedGoal.frequency)")
//                          .font(.subheadline)
//                          .foregroundColor(.black)
//                          .frame(maxWidth: .infinity, alignment: .trailing)
//                      }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
//                      ZStack(alignment: .leading) {
//                        Capsule().frame(width: progressBarMax)
//                          .foregroundColor(Color.gray)
//                        Capsule().frame(width: progressBarMax * percentage)
//                          .foregroundColor(Color.yellow)
//                      }.frame(height: 20, alignment: .center)
//                        .padding(.leading, 10)
//                      Spacer()
//                    }
//                  )
                RoundedRectangle(cornerRadius: 12)
                        .fill(Color.blue)
                        .overlay(
                            VStack {
                                HStack {
                                    Text(feedGoal.name)
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("\(feedGoal.progress)/\(feedGoal.frequency)")
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                .padding(.leading, 10)
                                
                                ZStack(alignment: .leading) {
                                    Capsule().frame(width: progressBarMax)
                                        .foregroundColor(Color.gray)
                                    Capsule().frame(width: progressBarMax * percentage)
                                        .foregroundColor(Color.yellow)
                                }
                                .frame(height: 20, alignment: .center)
                                
//                                Spacer() // Move Spacer inside the VStack
                            }
                        )
                
              }
//              .background(.blue)
              .padding()
            
          }
          // Image and Reactions
          ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
            // Photo
            Image(uiImage: postController.getImageFromURL(url: post.photo))
              .resizable()
              .scaledToFill()
              .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 500)
              .clipped()
            
            
            VStack(alignment: .leading){
              if isShowingPopUp {
                ReactionsComponent(post: post)
                Button(action: {
                  isShowingPopUp.toggle()
                }) {
                  Image("Reaction")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40, alignment: .leading)
                }
              } else {
                Button(action: {
                  isShowingPopUp.toggle()
                }) {
                  Image("bwHexagon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40, alignment: .leading)
                }
              }
            }
            .padding(.leading, 10)
            .padding(.bottom, 7)
          }
          
          //Subgoal
          VStack (alignment: .leading) {
            if let subgoal = goalController.getSubgoalFromId(subgoalId: post.subgoalId!){
              Capsule()
                .foregroundColor(Color.green)
                .frame(height: 20, alignment: .leading)
                .overlay(
                  HStack{
                    Image(systemName: "checkmark.circle")
                      .frame(width: 20, alignment: .leading)
                    Text(subgoal.name)
                      .font(.system(size: 10))
                      .frame(maxWidth: .infinity, alignment: .leading)
                  }
                )
                .frame(maxWidth: 150, alignment: .leading)
            }
            
            if (post.caption != "") {
              Text(post.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
          }
          
          VStack {
            Text("View Comments")
              .foregroundColor(.gray)
              .font(.system(size: 10))
              .onTapGesture {
                isSheetPresented.toggle()
              }
              .sheet(isPresented: $isSheetPresented) {
                CommentSheetView(post: post)
              }
              .padding()
          }
        }
        .background(
          RoundedRectangle(cornerRadius: 12)
              .fill(Color.white)
              .frame(minHeight: 0, maxHeight: .infinity)
              .shadow(color: Color.gray, radius: 4, x: 0, y: 2)
        )
        .frame(minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .padding(.top, 1)
        .padding(.bottom, 1)
        .padding(.leading, 5)
        .padding(.trailing, 5)
            
      }
    }
}
