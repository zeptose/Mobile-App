//
//  ProfilesView.swift
//  BusyBee
//
//  Created by elaine wang on 11/1/23.
//

import SwiftUI

struct ProfileView: View {
  @EnvironmentObject var viewModel: AuthViewModel
  @ObservedObject var goalController = GoalController()
  let customYellow = Color(UIColor(hex: "#FFD111"))
  var user: User?
    var body: some View {
      if let profile = user {
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
            NavigationLink(destination: AddGoalView(goalController: goalController, user: profile)) {
              Text("Add Goal")
            }
            .padding()
            HStack {
              Spacer()
              
              Button(action: {
                print("Current Goals button tapped")
              }) {
                Text("Current Goals")
                  .padding()
                  .foregroundColor(.white)
                  .background(Color.yellow)
                  .cornerRadius(8)
              }
              .onTapGesture {
                                  // Access and display current goals from the repository
                let currentGoals = goalController.getCurrentGoals(currentUser: profile)
                                  // Use 'currentGoals' to display in the UI or perform any necessary action
                print(currentGoals)
                VStack {
                    ForEach(currentGoals) { goal in
                        Text(goal.name)
                        .frame(width: 100, height: 100)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding()
                }
                }
                
              }
              
              Button(action: {
                print("Past Goals button tapped")
              }) {
                Text("Past Goals")
                  .padding()
                  .foregroundColor(.white)
                  .background(Color.yellow)
                  .cornerRadius(8)
              }
              
              Spacer()
            }
            
            Spacer()
          }
        }
        .edgesIgnoringSafeArea(.top)
          // Background Image
          .background(
          GeometryReader { geometry in
            Image("HoneyGraphic")
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: geometry.size.width)
              .frame(maxHeight: UIScreen.main.bounds.height / 3)
              .edgesIgnoringSafeArea(.top)
          })
      }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//      ProfileView()
//
//    }
//}
