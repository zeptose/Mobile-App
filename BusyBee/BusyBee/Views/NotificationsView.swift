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
    let info: String
    
    static func < (lhs: AppNotification, rhs: AppNotification) -> Bool {
          return lhs.timestamp < rhs.timestamp
      }
      
    func hash(into hasher: inout Hasher) {
            hasher.combine(type)
            hasher.combine(postId)
            hasher.combine(commenterId)
            hasher.combine(timestamp)
            hasher.combine(info)
        }
        
        static func == (lhs: AppNotification, rhs: AppNotification) -> Bool {
            return lhs.type == rhs.type &&
                lhs.postId == rhs.postId &&
                lhs.commenterId == rhs.commenterId &&
                lhs.timestamp == rhs.timestamp &&
                lhs.info == rhs.info
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
        .padding(.top, 5).padding(.bottom, 5)
      
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
                    
                    HStack {
                        Text("\(commenter.username) commented: \"\(notification.info)\"")
                        Spacer()
                        
                        Image(uiImage: postController.getImageFromURL(url: post.photo))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipped()
                    }
                } else {
                    AnyView(EmptyView())
                }
                
            case .reaction:
                if let post = postController.getPostFromId(postId: notification.postId),
                   let reactingUser = postController.userRepository.getUserWithId(notification.commenterId) {
                    
                    HStack {
                        Text("\(reactingUser.username) reacted with \(notification.info)")
                        Spacer()
                        
                        Image(uiImage: postController.getImageFromURL(url: post.photo))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipped()
                    }
                }
                
            case .follow:
                if let follower = postController.userRepository.getUserWithId(notification.info){
                    
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
                    
                  
                }
            }
        }
    }
}
