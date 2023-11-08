//
//  ProfilesView.swift
//  BusyBee
//
//  Created by elaine wang on 11/1/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var goalController: GoalController
    @EnvironmentObject var userController: UserController
    let customYellow = Color(UIColor(hex: "#FFD111"))
    @State var displayedCurrentGoals: [Goal] = []
    @State private var showCurrentGoals = true
    @State private var isEditingProfile = false
    var user: User?
//    @State var curr: User?

    var body: some View {
      if let profile = user {
            let currentGoals = goalController.getCurrentGoals(currentUser: profile)
            let updatedUser = userController.getUserFromId(userId: profile.id)
            let updatedCurrentUser = userController.getUserFromId(userId: viewModel.currentUser!.id)
//            let currentFollows = updatedCurrentUser!.follows
            ZStack {
                VStack {
                    HStack {
                        Button(action: {
                            print("Back button tapped")
                        }) {
                            Image(systemName: "arrow.left")
                        }
                        .padding().padding().padding()

                        Spacer()

                        Button(action: {
                            print("Settings button tapped")
                        }) {
                            Image(systemName: "gear")
                        }
                        .padding()
                    }

                    Image("profilePic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(customYellow, lineWidth: 10))

                  Text(updatedUser!.username)
                        .font(.headline)
                        .padding()
                    
                  if let bio = updatedUser?.bio {
                        Text(bio)
                            .font(.caption)
                            .padding()
                    }
                  
                    Spacer()

    

                    if updatedUser ==
                        updatedCurrentUser {
                        Button("Logout") {
                            Task {
                                viewModel.signOut()
                            }
                        }
               
                      NavigationLink(destination: EditProfileView(user: updatedUser!, userController: userController)) {
                            Text("Edit Profile")
                      }.padding()
                        NavigationLink(destination: AddGoalView(goalController: goalController, user: updatedUser!)) {
                            Text("Add Goal")
                        }
                        .padding()
                    } else if userController.isFollowing(currentUser: updatedCurrentUser!, otherUser: updatedUser!) {
//                      Button(action: {
//                        userController.toggleFriendStatus(currentUser: viewModel.currentUser!, friend: profile)
//                      }) {
//                        Text(userController.isFriend ? "Unfriend" : "Add Friend")
//                      }
                      Button(action: {
                        userController.unfollowFriend(currentUser: updatedCurrentUser!, unfollow: updatedUser!)
                      }) {
                        Text("Unfollow")
                      }

                    } else {
                      
                      Button(action: {
                        userController.followFriend(currentUser: updatedCurrentUser!, follow: updatedUser!)
                      }) {
                        Text("Follow")
                      }
                    }

                    VStack {
                        HStack {
                            Spacer()

                            Button(action: {
                                showCurrentGoals = true
                            }) {
                                Text("Current Goals")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.yellow)
                                    .cornerRadius(8)
                            }

                            Button(action: {
                                showCurrentGoals = false
                            }) {
                                Text("Past Goals")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.yellow)
                                    .cornerRadius(8)
                            }

                            Spacer()
                        }

                        ScrollView {
                            VStack {
                                if showCurrentGoals {
                                    let dateFormatter: DateFormatter = {
                                        let formatter = DateFormatter()
                                        formatter.dateFormat = "yyyy-MM-dd"
                                        return formatter
                                    }()

                                    ForEach(currentGoals) { goal in
                                        NavigationLink(destination: IndividualGoalView(goal: goal)) {
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color.white)
                                                .shadow(color: Color.gray, radius: 4, x: 0, y: 2)
                                                .frame(width: UIScreen.main.bounds.width * 0.85, height: 120)
                                                .overlay(
                                                    VStack(alignment: .leading) {
                                                        Text(goal.name)
                                                            .font(.title)
                                                            .fontWeight(.bold)
                                                            .padding(.bottom, 4)
                                                        HStack {
                                                            Text("Due: \(dateFormatter.string(from: goal.dueDate))")
                                                                .font(.subheadline)
                                                            Spacer()
                                                            Text("Frequency: \(goal.frequency)")
                                                                .font(.subheadline)
                                                                .multilineTextAlignment(.trailing)
                                                        }
                                                    }
                                                    .padding(12)
                                                )
                                        }
                                    }
                                } else {
                                    let pastGoals = goalController.getPastGoals(currentUser: updatedUser!)
                                    let dateFormatter: DateFormatter = {
                                        let formatter = DateFormatter()
                                        formatter.dateFormat = "yyyy-MM-dd"
                                        return formatter
                                    }()

                      ForEach(pastGoals) { goal in
                          NavigationLink(destination: IndividualGoalView(goal: goal)) {
                              RoundedRectangle(cornerRadius: 12)
                                  .fill(Color.white)
                                  .shadow(color: Color.gray, radius: 4, x: 0, y: 2)
                                  .frame(width: UIScreen.main.bounds.width * 0.85, height: 120)
                                  .overlay(
                                      VStack(alignment: .leading) {
                                          Text(goal.name)
                                              .font(.title)
                                              .fontWeight(.bold)
                                              .padding(.bottom, 4)
                                          HStack {
                                              Text("Due: \(dateFormatter.string(from: goal.dueDate))")
                                                  .font(.subheadline)
                                              Spacer()
                                              Text("Frequency: \(goal.frequency)")
                                                  .font(.subheadline)
                                                  .multilineTextAlignment(.trailing)
                                          }
                                      }
                                      .padding(12)
                                  )
                          }
                      }
                  }
              }
          }
      }

      Spacer()
  }
  .edgesIgnoringSafeArea(.top)
  .background(
      GeometryReader { geometry in
          Image("HoneyGraphic")
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: geometry.size.width)
              .frame(maxHeight: UIScreen.main.bounds.height / 3)
              .edgesIgnoringSafeArea(.top)
                    }
                )
            }
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}


