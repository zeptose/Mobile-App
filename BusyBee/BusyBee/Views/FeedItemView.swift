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
  
    var body: some View {
      if let feedUser = userController.getUserFromId(userId: userId){
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
              RoundedRectangle(cornerRadius: 12)
                .fill(Color(.clear))
                .frame(height: 45)
                .overlay(
                  VStack{
                    Spacer()
                    HStack{
                      Text(feedGoal.name)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                      //                      .padding(.leading, 10)
                      Text("\(feedGoal.progress)/\(feedGoal.frequency)")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    Spacer()
                    ZStack(alignment: .leading) {
                      Capsule().frame(width: progressBarMax)
                        .foregroundColor(Color.gray)
                      Capsule().frame(width: progressBarMax * percentage)
                        .foregroundColor(Color.yellow)
                    }.frame(height: 20, alignment: .center)
                    .padding(.leading, 10)
                    Spacer()
                  }
                )
            }
                
        }
        ZStack(alignment: .bottom) {
            // Photo
            Image(uiImage: postController.getImageFromURL(url: post.photo))
              .resizable()
              .scaledToFill()
              .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 280)
              .clipped()
//          HStack {
////              let colors = postController.getUserReaction(userId: userId, postId: post.id!)
//              Button(action: {
//                postController.reactToPost(userId: userId, reactionNum: 1, postId: post.id!)
//              }) {
//                VStack{
//                  Circle()
//                      .fill(Color.blue)
//                      .overlay(
//                          Image("heart")
//                              .resizable()
//                              .aspectRatio(contentMode: .fit)
//                              .frame(width: 30, height: 30, alignment: .leading)
//                      )
//              }
//            }
//
//              Button(action: {
//                postController.reactToPost(userId: userId, reactionNum: 2, postId: post.id!)
//              }) {
//                VStack {
//                  Circle()
//                      .fill(Color.blue)
//                      .overlay(
//                          Image("clappingHands")
//                              .resizable()
//                              .aspectRatio(contentMode: .fit)
//                              .frame(width: 30, height: 30, alignment: .leading)
//                      )
//              }
//            }
//
//              Button(action: {
//                postController.reactToPost(userId: userId, reactionNum: 3, postId: post.id!)
//              }) {
//                VStack {
//                  Circle()
//                      .fill(Color.blue)
//                      .overlay(
//                          Image("champagne")
//                              .resizable()
//                              .aspectRatio(contentMode: .fit)
//                              .frame(width: 30, height: 30, alignment: .leading)
//                      )
//              }
//            }
//
//              Button(action: {
//                postController.reactToPost(userId: userId, reactionNum: 4, postId: post.id!)
//              }) {
//                VStack {
//                  Circle()
//                      .fill(Color.blue)
//                      .overlay(
//                          Image("celebrate")
//                              .resizable()
//                              .aspectRatio(contentMode: .fit)
//                              .frame(width: 30, height: 30, alignment: .leading)
//                      )
//              }
//            }
//            }
        }
        
        VStack {
          //Subgoal
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
            
        }
        Spacer()
//        .padding()
      }
}
