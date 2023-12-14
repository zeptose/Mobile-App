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
    @EnvironmentObject var userController: UserController
    var user: User?
    let customYellow = Color(UIColor(hex: "#FFD111"))

    var body: some View {
        if let temp = user {
          let currUser = userController.getUserFromId(userId: temp.id)
          let allPosts = postController.getFeedPosts(currUser: currUser!)
          
          VStack {
            Spacer()
            HStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                    .foregroundColor(.white)
                    .padding(.leading, 15)
                Spacer()
                Image("feedHeader")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120)
                Spacer()
                NavigationLink(destination: SearchView()
                                                .navigationBarBackButtonHidden(true)) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                        .foregroundColor(customYellow)
                        .padding(.trailing, 15)
                }
            }.padding(.top, 5)
            
            List {
              ForEach(allPosts) { post in
                FeedItemView(userId: post.userId, currentPost: post)
                  .multilineTextAlignment(.leading)
                  .padding(.bottom, 0)
              }
              .listRowSeparator(.hidden)
            }.listStyle(PlainListStyle())
          }
      }
    }
}
