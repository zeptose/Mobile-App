// ContentView.swift
// BusyBee
// Created by elaine wang on 10/24/23.

// ContentView.swift
import SwiftUI

struct ContentView: View {
    @State private var isRegistering = true
    @State private var isLoggingIn = true
    @ObservedObject var goalRepository = GoalRepository()
    @State private var selectedTab = 4 // Assuming "Profile" is the 5th tab (index 4)
    @EnvironmentObject var viewModel: AuthViewModel
  
    var body: some View {
        NavigationView {
          if viewModel.userSession == nil {
            NavigationView {
                VStack {
                  Text("BusyBee")
                      .font(.largeTitle)
                      .foregroundColor(Color.yellow)
                      .padding(.top, 20)
                  
                  Spacer()
                  NavigationLink(destination: RegistrationFormView(isRegistering: $isRegistering, selectedTab: $selectedTab)
                    .environmentObject(goalRepository)) {
                    Text("Register")
                  }
                  .font(.title)
                  .foregroundColor(Color.blue)
                  .padding()
                  .overlay(
                      RoundedRectangle(cornerRadius: 10)
                          .stroke(Color.blue, lineWidth: 2)
                  )
                  Spacer()
                  NavigationLink(destination: LoginFormView(isLoggingIn: $isLoggingIn, selectedTab: $selectedTab)) {
                    Text("Login")
                  }
                  .font(.title)
                  .foregroundColor(Color.blue)
                  .padding()
                  .overlay(
                      RoundedRectangle(cornerRadius: 10)
                          .stroke(Color.blue, lineWidth: 2)
                  )
                  Spacer()
                }
            }
          } else {
              AppView()
                  
          }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
