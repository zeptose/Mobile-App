//
//  HomeView.swift
//  BusyBee
//
//  Created by Ryan McGrady on 11/2/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var postController: PostController
    @EnvironmentObject var viewModel: AuthViewModel
    var user: User?

  var body: some View {
      if let currUser = user {
        let allPosts = postController.getFeedPosts(currUser: currUser)
        
        VStack {
          Spacer()
          Text("BusyBee")
          
          List {
            ForEach(allPosts) { post in
              FeedItemView(userId: post.userId, post: post)
                .multilineTextAlignment(.leading)
            }
          }
        }
      }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//      let sampleUser = User(id: "dskmSXft9neXeZC5MfTlMXUqCBy1", username: "SampleUser", bio: "Sample Bio", goals: [], posts: [], follows: [])
//      HomeView(user: sampleUser)
//
//    }
//}
