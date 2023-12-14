//
//  FeedItemView.swift
//  BusyBee
//
//  Created by elaine wang on 11/7/23.
//

import SwiftUI

struct FeedItemView: View {
    var userId: String
    var currentPost: Post
    @EnvironmentObject var postController: PostController
    @EnvironmentObject var userController: UserController
    @EnvironmentObject var goalController: GoalController
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isShowingPopUp = false
    @State private var isSheetPresented = false
    @State var navigateTo: AnyView?
    @State var isNavigationActive = false
    let customYellow = Color(UIColor(hex: "#FFD111"))
    let subgoalColor = Color(UIColor(hex: "#F08355"))
  
    var body: some View {
      if let post = postController.getPostFromId(postId: currentPost.id!) {
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
                  .font(Font.custom("Quicksand-Bold", size: 16))
                Text(timeAgo)
                  .foregroundColor(.gray)
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .font(Font.custom("Quicksand-Regular", size: 16))

              }
              Spacer()
              
              if feedUser == viewModel.currentUser {
                VStack {
                  Menu {
                    Button("Edit Post") {
                      navigateTo = AnyView(EditPostView(currentUser: feedUser, post: post))
                      isNavigationActive = true
                    }
                    Button("Delete Post") {
                      postController.deletePost(post: post, currentUser: feedUser)
                    }
                  } label: {
                    Image(systemName: "ellipsis")
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                      .frame(width: 20)
                      .foregroundColor(.black)
                  }
                  .padding()
                }
                
              }
              
              
              
            }
          }

          
          // Goal and Progress
          
          if let feedGoal = goalController.getGoalFromId(goalId: post.goalId) {
            let percentage = CGFloat(feedGoal.progress)/CGFloat(feedGoal.frequency)
            let progressBarMax = UIScreen.main.bounds.width - 75
            
            NavigationLink(destination: IndividualGoalView(goal: feedGoal)) {
              RoundedRectangle(cornerRadius: 12)
                .fill(Color.clear)
                .frame(height: 40)
                .overlay(
                  VStack(alignment: .leading) {
                    Spacer()
                    HStack {
                      Text(feedGoal.name)
                        .font(Font.custom("Quicksand-Regular", size: 16))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                      Text("\(feedGoal.progress)/\(feedGoal.frequency)")
                        .font(Font.custom("Quicksand-Regular", size: 16))
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
                ReactionsComponent(post: post, isShowingPopUp: $isShowingPopUp)
                Button(action: {
                  isShowingPopUp.toggle()
                }) {
                  Image("Reaction")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 55, height: 55, alignment: .leading)
                }
              } else {
                Button(action: {
                  isShowingPopUp.toggle()
                }) {
                  Image("bwHexagon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 55, height: 55, alignment: .leading)
                }
              }
            }
            .padding(.leading, 10)
            .padding(.bottom, 7)
          }.padding(.bottom, 0)
          
          //Subgoal
          VStack (alignment: .leading) {
            if let subgoal = goalController.getSubgoalFromId(subgoalId: post.subgoalId!) {
                    HStack(spacing: 10) {
                        Image("checkmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 12, alignment: .leading)
                            .padding(.leading, 10)

                        Text(subgoal.name)
                            .font(Font.custom("Quicksand-Regular", size: 16))
                            .foregroundColor(.white)
                            .padding(.trailing, 10)
                    }
                    .background(
                        Capsule()
                            .foregroundColor(subgoalColor)
                            .frame(height: 25)
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 1)
                }

                if !post.caption.isEmpty {
                    Text(post.caption)
                        .font(Font.custom("Quicksand-Regular", size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, -1)
                }
          }
          .padding(.top, -5)
          
          Text("View Comments")
            .foregroundColor(.gray)
            .font(Font.custom("Quicksand-Regular", size: 14))
            .padding(.leading, 1.25)
            .padding(.top, -15)
            .onTapGesture {
              isSheetPresented.toggle()
            }
            .sheet(isPresented: $isSheetPresented) {
              CommentSheetView(post: post)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

        }

      }
      if let post = postController.getPostFromId(postId: currentPost.id!) {
        if let feedUser = userController.getUserFromId(userId: userId){
          NavigationLink(
            destination: EditPostView(currentUser: feedUser, post: post),
            isActive: $isNavigationActive
          ) {
            EmptyView()
          }
          .hidden()
        }
      }
    } 
}
