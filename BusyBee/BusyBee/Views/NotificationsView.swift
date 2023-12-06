//
//  NotificationsView.swift
//  BusyBee
//
//  Created by Ryan McGrady on 12/4/23.
//

import SwiftUI

struct AppNotification: Hashable, Comparable {
    let type: NotificationType
    let postId: String
    let commenterId: String
    let timestamp: Date
    
    static func < (lhs: AppNotification, rhs: AppNotification) -> Bool {
          return lhs.timestamp < rhs.timestamp
      }
      
      static func == (lhs: AppNotification, rhs: AppNotification) -> Bool {
          return lhs.timestamp == rhs.timestamp
      }
  }

enum NotificationType {
    case comment
    case reaction
    case follow
}



struct NotificationView: View {
  @StateObject var postController = PostController()
  @StateObject var userController = UserController()
  @State var notifications: [AppNotification] = []
  @EnvironmentObject var viewModel: AuthViewModel
  
  
  var body: some View {
    VStack {
      Image("feedHeader")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 120)
      
      List {
        ForEach(notifications, id: \.self) { notification in
          NotificationRow(notification: notification, postController: postController, userController: userController)
        }
      }
    }
    .onAppear {
      if let currentUser = viewModel.currentUser {
        notifications = postController.getNotificationsForCurrentUser(currentUser: currentUser)
        notifications.sort()
      }
    }
    
  }
  
  
  struct NotificationRow: View {
    @EnvironmentObject var viewModel: AuthViewModel
    let notification: AppNotification
    let postController: PostController
    let userController: UserController
    
    var body: some View {
      VStack {
        
        
        switch notification.type {
        case .comment:
            if let commenter = postController.userRepository.getUserWithId(notification.commenterId),
               let post = postController.getPostFromId(postId: notification.postId) {
                
                // Filter comments by the commenterId
                let userComments = post.comments.filter { $0.userId == notification.commenterId }
                
                // Get unique comments by their identifier
                let uniqueComments = Array(Set(userComments.map { $0.id }))
                
                // Display each unique comment for the user
                ForEach(uniqueComments, id: \.self) { commentID in
                    if let comment = userComments.first(where: { $0.id == commentID }) {
                        HStack {
                            Text("\(commenter.username) commented: \"\(comment.body)\"")
                            Spacer()
                            
                            Image(uiImage: postController.getImageFromURL(url: post.photo))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .clipped()
                        }
                    }
                }
            } else {
                AnyView(EmptyView())
            }


          
          
        case .reaction:
          if let post = postController.getPostFromId(postId: notification.postId),
             let reactingUser = postController.userRepository.getUserWithId(notification.commenterId) {
            let reactionText = postController.getReactionText(forPost: post, commenterId: notification.commenterId)
            
            
            HStack {
              Text("\(reactingUser.username) reacted with \(reactionText)")
              Spacer()
              
              Image(uiImage: postController.getImageFromURL(url: post.photo))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipped()
              
            }
          }
        case .follow:
          if let follower = postController.userRepository.getUserWithId(notification.commenterId){
            
            HStack {
              Image("profilePic")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
              
              
              Text("\(follower.username) has followed you")
                .foregroundColor(Color(red: 14/255, green: 118/255, blue: 168/255)) // Instagram blue color
                .font(.callout) // Adjust the font size and style to match Instagram
                .padding(.leading, 8)
            }
            
            Spacer()
            
            if let currentUser = viewModel.currentUser,
               userController.currentUserIsFollowingFollower(currentUser: currentUser, followerId: follower.id) {
              Text("Following")
                .foregroundColor(.gray)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .overlay(
                  RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.gray, lineWidth: 1)
                )
            } else {
              Button(action: {
                if let currentUser = viewModel.currentUser {
                  userController.followFriend(currentUser: currentUser, follow: follower)
                }
              }) {
                Text("Follow")
                  .foregroundColor(.blue)
                  .padding(.horizontal, 8)
                  .padding(.vertical, 4)
                  .overlay(
                    RoundedRectangle(cornerRadius: 4)
                      .stroke(Color.blue, lineWidth: 1)
                  )
              }
            }
            
            
          }
        }
      }
    }
  }
}
