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
    var user: User?
  
  let customMaroon = Color(UIColor(hex: "#992409"))



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
                        .padding()

                        Spacer()

                      Button("Logout") {
                          Task {
                              viewModel.signOut()
                          }
                      }.padding()
                      
                      
                    }.padding(.top, 35)

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


                    if profile == viewModel.currentUser {
                        NavigationLink(destination: AddGoalView(goalController: goalController, user: profile)) {
                          Text("Add Goal")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .padding(5)
                            .frame(width: UIScreen.main.bounds.width * 0.3)
                            .background(customMaroon)
                            .cornerRadius(100)
                        }
                    }

                    VStack {
                        HStack {
                            Spacer()

                          TabBarButton(text: "Current Goals", isSelected: showCurrentGoals) {
                            withAnimation {
                              showCurrentGoals = true
                            }
                          }
                          
                          Spacer()
                          TabBarButton(text: "Past Goals", isSelected: showCurrentGoals == false) {
                            withAnimation {
                              showCurrentGoals = false
                            }

                          }

                            Spacer()
                        }
                        .overlay(Rectangle().frame(width: nil, height: 2, alignment: .bottom).foregroundColor(Color.gray), alignment: .bottom)



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

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
