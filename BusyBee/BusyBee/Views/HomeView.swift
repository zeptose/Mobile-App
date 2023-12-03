//
//  HomeView.swift
//  BusyBee
//
//  Created by Ryan McGrady on 11/2/23.
//

//import SwiftUI
//
//struct HomeView: View {
//    @EnvironmentObject var postController: PostController
//    @EnvironmentObject var viewModel: AuthViewModel
//    @EnvironmentObject var userController: UserController
//    var user: User?
//    let customYellow = Color(UIColor(hex: "#FFD111"))
//
//    var body: some View {
//        if let temp = user {
//            let currUser = userController.getUserFromId(userId: temp.id)
//            let allPosts = postController.getFeedPosts(currUser: currUser!)
//
//            VStack {
//                List {
//                    Section(header:
//                          HStack {
//                              Spacer()
//                              Image("feedHeader")
//                                  .resizable()
//                                  .aspectRatio(contentMode: .fit)
//                                  .frame(width: 120)
//                                  .padding(.trailing, 40)
//                              NavigationLink(destination: SearchView()) {
//                                  Image(systemName: "magnifyingglass")
//                                      .resizable()
//                                      .aspectRatio(contentMode: .fit)
//                                      .frame(width: 20)
//                                      .foregroundColor(customYellow)
//                              }
//                          }
//                    ) {
//                        ForEach(allPosts) { post in
//                            FeedItemView(userId: post.userId, post: post)
//                                .multilineTextAlignment(.leading)
//                        }
//                    }.listRowSeparator(.hidden)
//                }.listStyle(PlainListStyle())
//            }
//        }
//    }
//}
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
            }
            
            List {
              ForEach(allPosts) { post in
                FeedItemView(userId: post.userId, post: post)
                  .multilineTextAlignment(.leading)
              }
              .listRowSeparator(.hidden)
            }.listStyle(PlainListStyle())
          }
      }
    }
}
