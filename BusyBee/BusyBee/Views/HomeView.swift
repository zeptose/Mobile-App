//
//  HomeView.swift
//  BusyBee
//
//  Created by Ryan McGrady on 11/2/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var postController = PostController()
    @EnvironmentObject var viewModel: AuthViewModel
    var user: User?

    var body: some View {
        if let currUser = user {
            let allPosts = postController.getFeedPosts(currUser: currUser)

            VStack {
                Spacer()
                Text("BusyBee")
                    .padding()
                
                List {
                    ForEach(allPosts) { post in
                        FeedItemView(userId: post.userId, post: post)
                    }
                }
            }
        }
    }
}

struct FeedItemView: View {
    var userId: String
    var post: Post
    @ObservedObject var postController = PostController()
    var body: some View {
        VStack {
            // Profile Picture and Username
            HStack {
                Image("profilePic") // Replace with user's profile image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                Text(userId)
                    .font(.headline)
            }
            
            // Photo
            Image(uiImage: postController.getImageFromURL(url: post.photo))
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .clipped()
        }
        .padding()
    }
}
