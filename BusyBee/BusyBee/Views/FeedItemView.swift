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
    let customYellow = Color(UIColor(hex: "#FFD111"))
    let subgoalColor = Color(UIColor(hex: "#53B141"))
  
    var body: some View {
      if let feedUser = userController.getUserFromId(userId: userId){
          let timeAgo = postController.timeAgoString(from: post.timePosted)
          VStack {
            // Profile Picture and Username
            
            HStack {
              Image("profilePic")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(customYellow, lineWidth: 3))
              
              VStack {
                Text(feedUser.username)
                  .frame(maxWidth: .infinity, alignment: .leading)
                Text(timeAgo)
                  .foregroundColor(.gray)
                  .font(.system(size: 12))
                  .frame(maxWidth: .infinity, alignment: .leading)
              }
            }
          }
          
          // Goal and Progress
          
          if let feedGoal = goalController.getGoalFromId(goalId: post.goalId) {
            let percentage = CGFloat(feedGoal.progress)/CGFloat(feedGoal.frequency)
            let progressBarMax = UIScreen.main.bounds.width - 85
            
            NavigationLink(destination: IndividualGoalView(goal: feedGoal)) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.clear)
                    .frame(height: 40)
                    .overlay(
                      VStack(alignment: .leading) {
                          Spacer()
                            HStack {
                                Text(feedGoal.name)
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("\(feedGoal.progress)/\(feedGoal.frequency)")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.trailing, 20)
                            }
//                            .padding(.leading, 10)
                          Spacer()
                            ZStack(alignment: .leading) {
                                Capsule().frame(width: progressBarMax)
                                    .foregroundColor(Color.gray)
                                Capsule().frame(width: progressBarMax * percentage)
                                    .foregroundColor(Color.yellow)
                            }
                            .frame(height: 20, alignment: .center)
                           Spacer()
                        }
                    )
            }
          }
          // Image and Reactions
          ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
            // Photo
            Image(uiImage: postController.getImageFromURL(url: post.photo))
              .resizable()
              .scaledToFill()
              .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 400)
              .clipped()
              .edgesIgnoringSafeArea([.top, .bottom])
            
            
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
          }.padding(.bottom, 0)
          
          //Subgoal
        VStack (alignment: .leading) {
            if let subgoal = goalController.getSubgoalFromId(subgoalId: post.subgoalId!){
              Capsule()
                .foregroundColor(subgoalColor)
                .frame(height: 25, alignment: .leading)
                .overlay(
                  HStack{
                    Image("checkmark")
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                      .frame(width: 12, alignment: .leading)
                      .padding(.leading, 10)
                    Text(subgoal.name)
                      .font(.system(size: 15))
                      .foregroundColor(.white)
                      .frame(maxWidth: .infinity, alignment: .leading)
                    
                  }
                )
                .frame(maxWidth: 150, alignment: .leading)
            }
            
            if (post.caption != "") {
              Text(post.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, -1)
            }
        }
        .padding(.top, -5)
        
        Text("View Comments")
          .foregroundColor(.gray)
          .font(.system(size: 12))
          .padding(.leading, 2)
          .padding(.top, -20)
          .onTapGesture {
            isSheetPresented.toggle()
          }
          .sheet(isPresented: $isSheetPresented) {
            CommentSheetView(post: post)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
//        .background(
//          RoundedRectangle(cornerRadius: 12)
//              .fill(Color.white)
//              .frame(minHeight: 0, maxHeight: .infinity)
//              .shadow(color: Color.gray, radius: 4, x: 0, y: 2)
//        )
////        .frame(minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
//        .frame(minHeight: 0, maxHeight: .infinity)
//        .padding(.top, 1)
//        .padding(.bottom, 1)
//        .padding(.leading, 1)
//        .padding(.trailing, 1)
            
      
    }
}
