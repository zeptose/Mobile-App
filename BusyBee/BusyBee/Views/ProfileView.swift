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
    let customMaroon = Color(UIColor(hex: "#992409"))
    @State private var isWiggling = false

  @State private var gradient = Gradient(colors: [Color.yellow, Color.orange])
  @State private var startPoint = UnitPoint(x: 0.5, y: 0.0)
  @State private var endPoint = UnitPoint(x: 0.5, y: 1.0)
    
    var body: some View {
        if let profile = user {
            let currentGoals = goalController.getCurrentGoals(currentUser: profile)
            let updatedUser = userController.getUserFromId(userId: profile.id)
            if let temp = viewModel.currentUser {
                let updatedCurrentUser = userController.getUserFromId(userId: temp.id)
                //            let currentFollows = updatedCurrentUser!.follows
                ZStack {
                    VStack {
                        HStack {
                            Spacer()
                          
                          if updatedUser ==
                              updatedCurrentUser {
                            Button("Logout") {
                              Task {
                                viewModel.signOut()
                              }
                            }.padding().foregroundColor(Color.black)
                          } else{
                            HStack{}.padding(.top, 35)
                          }
                        }.padding(.top, 35)
                      
                        
                        Image("profilePic")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(customYellow, lineWidth: 10))
                      ZStack {
                          Image("ProfileBee")
                                      .resizable()
                                      .scaledToFit()
                                      .frame(width: 70, height: 70)
//                                      .padding(.top, 10)
                                      .padding(.trailing, 200)
                                      .rotationEffect(isWiggling ? Angle(degrees: 3) : Angle(degrees: -3))
                                      .onAppear() {
                                          withAnimation(Animation.easeInOut(duration: 0.4).repeatForever(autoreverses: true)) {
                                              self.isWiggling.toggle()
                                          }
                                      }

                        VStack {
                          Text(updatedUser!.username)
                            .font(Font.custom("Quicksand-Regular", size: 32))
                            .bold()
                            .padding(.bottom, 9)

                          
                          if let bio = updatedUser?.bio {
                            if bio != "" {
                              Text(bio)
                                .font(Font.custom("Quicksand-Bold", size: 16))
                                .foregroundColor(.gray)
                                .font(Font.custom("Quicksand-Regular", size: 16))
                            }
                          }
                        }
                        Spacer()
                        Image("ProfileBeeClear")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 70, height: 70)
                            .padding(.top, 20)
                            .padding(.trailing, 10)
                      }
//
                        if updatedUser ==
                            updatedCurrentUser {

                          HStack{
                              NavigationLink(destination: AddGoalView(goalController: goalController, user: updatedCurrentUser!)) {
                                Label("Add Goal", systemImage: "plus")
                                  .font(Font.custom("Quicksand-Regular", size: 16))
                                  .foregroundColor(.white)
                                  .padding(8)
                                  .frame(width: UIScreen.main.bounds.width * 0.45, height: 40)
                                  .background(LinearGradient(gradient: gradient, startPoint: startPoint, endPoint: endPoint))
                                  .cornerRadius(8)
                                  .animation(
                                        Animation.linear(duration: 2.0).repeatForever(autoreverses: true)
                                                      )
                                  .onAppear() {
                                    startPoint = UnitPoint(x: 0.5, y: 1.0)
                                  endPoint = UnitPoint(x: 0.5, y: 0.0)
                                }

                              }
                            NavigationLink(destination: EditProfileView(user: updatedCurrentUser!, userController: userController)) {
                              
                              Label("Edit Profile", systemImage: "pencil")
                            }
                            .font(Font.custom("Quicksand-Regular", size: 16))
                            .foregroundColor(customMaroon)
                            .padding(5)
                            .frame(width: UIScreen.main.bounds.width * 0.45, height: 40)
                            .background(RoundedRectangle(cornerRadius: 8)
                                .stroke(customMaroon, lineWidth: 1))
                            
                            
                          }.padding(.top, 1)
                        } else if userController.isFollowing(currentUser: updatedCurrentUser!, otherUser: updatedUser!) {
                            Button(action: {
                                userController.unfollowFriend(currentUser: updatedCurrentUser!, unfollow: updatedUser!)
                            }) {
                                Text("Unfollow")
                            }
                            .font(Font.custom("Quicksand-Regular", size: 16))
                            .foregroundColor(.white)
                            .padding(5)
                            .frame(width: UIScreen.main.bounds.width * 0.45, height: 40)
                            .background(customMaroon)
                            .cornerRadius(70)
                            .padding(.top, 1)
                            
                        } else {
                            
                            Button(action: {
                                userController.followFriend(currentUser: updatedCurrentUser!, follow: updatedUser!)
                            }) {
                                Text("Follow")
                            }
                            .font(Font.custom("Quicksand-Regular", size: 16))
                            .foregroundColor(.white)
                            .padding(5)
                            .frame(width: UIScreen.main.bounds.width * 0.45, height: 40)
                            .background(customMaroon)
                            .cornerRadius(70)
                            .padding(.top, 1)
                        }

                        VStack {
                            HStack {
                                Spacer()
                                
                                TabBarButton(text: "In Progress", isSelected: showCurrentGoals) {
                                    withAnimation {
                                      showCurrentGoals = true
                                    }
                                  }
                                  
                                  Spacer()
                                  TabBarButton(text: "Completed", isSelected: showCurrentGoals == false) {
                                    withAnimation {
                                      showCurrentGoals = false
                                    }

                                  }
                                
                                Spacer()
                            }.overlay(Rectangle().frame(width: nil, height: 2, alignment: .bottom)
                            .foregroundColor(Color.gray), alignment: .bottom)
                            .padding(.top, 15)

                            
                            ScrollView {
                                VStack {
                                    if showCurrentGoals {
                                        
                                      ForEach(currentGoals) { goal in
                                          NavigationLink(destination: IndividualGoalView(goal: goal)) {
                                              GoalCardView(user: updatedUser!, goal: goal)
                                          }
                                          }
                                    } else {
                                        let pastGoals = goalController.getPastGoals(currentUser: updatedUser!)
                                        ForEach(pastGoals) { goal in
                                            NavigationLink(destination: GoalWrappedView(goal: goal, user: updatedUser!)) {
                                                GoalCardView(user: updatedUser!, goal: goal)
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
}

struct TabBarButton: View {
    var text: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .padding(10)
                .foregroundColor(isSelected ? .yellow : .black)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 2)
                .frame(height: 4)
                .padding(.top, 30)
                .foregroundColor(isSelected ? .yellow : .clear)
                .animation(.easeInOut(duration: 0.2))
        )
    }
}
