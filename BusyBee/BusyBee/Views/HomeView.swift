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
          
          // Goal and Progress
          if let feedGoal = goalController.getGoalFromId(goalId: post.goalId){
            let percentage = CGFloat(feedGoal.progress)/CGFloat(feedGoal.frequency)
            let progressBarMax = UIScreen.main.bounds.width - 50
            Text(feedGoal.name)
              .font(.subheadline)
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(.leading, 10)
            
            ZStack(alignment: .leading) {
              Capsule().frame(width: progressBarMax)
                .foregroundColor(Color.gray)
              Capsule().frame(width: progressBarMax * percentage)
                .foregroundColor(Color.yellow)
            }.frame(height: 20)
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
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//      let sampleUser = User(id: "dskmSXft9neXeZC5MfTlMXUqCBy1", username: "SampleUser", bio: "Sample Bio", goals: [], posts: [], follows: [])
//      HomeView(user: sampleUser)
//
//    }
//}
