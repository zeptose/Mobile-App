//
//  ProfilesView.swift
//  BusyBee
//
//  Created by elaine wang on 11/1/23.
//

import SwiftUI

struct ProfileView: View {
<<<<<<< HEAD
  @EnvironmentObject var viewModel: AuthViewModel
  @ObservedObject var goalController = GoalController()
  let customYellow = Color(UIColor(hex: "#FFD111"))
  @State var displayedCurrentGoals : [Goal] = []
  @State private var showCurrentGoals = true
  var user: User?
    var body: some View {
      if let profile = user {
        let currentGoals = goalController.getCurrentGoals(currentUser: profile)
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
            
            Text(profile.username)
              .font(.headline)
              .padding()
            
            if profile.bio != nil {
              Text(profile.bio ?? "")
                .font(.caption)
                .padding()
            }
            Spacer()
            Button("Logout") {
              Task {
                viewModel.signOut()
              }
            }
            // add a goal
            if (profile == viewModel.currentUser) {
              NavigationLink(destination: AddGoalView(goalController: goalController, user: profile)) {
                Text("Add Goal")
              }
              .padding()
            }
            //            } else {
            //              Button(
            //            }
            
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
              
              VStack {
                if showCurrentGoals {
                  let dateFormatter: DateFormatter = {
                          let formatter = DateFormatter()
                          formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
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
                  let pastGoals = goalController.getPastGoals(currentUser: profile)
                  let dateFormatter: DateFormatter = {
                          let formatter = DateFormatter()
                          formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
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
=======
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var goalController: GoalController
    @EnvironmentObject var userController: UserController
    let customYellow = Color(UIColor(hex: "#FFD111"))
    @State var displayedCurrentGoals: [Goal] = []
    @State private var showCurrentGoals = true
    var user: User?

    var body: some View {
        if let profile = user {
            let currentGoals = goalController.getCurrentGoals(currentUser: profile)

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

                    Text(profile.username)
                        .font(.headline)
                        .padding()

                    if let bio = profile.bio {
                        Text(bio)
                            .font(.caption)
                            .padding()
                    }

                    Spacer()

                    Button("Logout") {
                        Task {
                            viewModel.signOut()
                        }
                    }

                    if profile == viewModel.currentUser {
                        NavigationLink(destination: AddGoalView(goalController: goalController, user: profile)) {
                            Text("Add Goal")
                        }
                        .padding()
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
                                    let pastGoals = goalController.getPastGoals(currentUser: profile)
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
>>>>>>> d20722c3f852ee12015e7e8ef0fec3cd91207ec6
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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


