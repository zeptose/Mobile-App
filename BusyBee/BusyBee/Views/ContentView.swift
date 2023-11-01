// ContentView.swift
// BusyBee
// Created by elaine wang on 10/24/23.

// ContentView.swift
import SwiftUI

struct ContentView: View {
    @State private var isRegistering = true // Start with registration form
    @ObservedObject var goalRepository = GoalRepository()
    @State private var selectedTab = 4 // Assuming "Profile" is the 5th tab (index 4)
    @EnvironmentObject var viewModel: AuthViewModel
  
    var body: some View {
        NavigationView {
          if viewModel.userSession == nil {
                RegistrationFormView(isRegistering: $isRegistering, selectedTab: $selectedTab)
                    .environmentObject(goalRepository)
            } else {
                ProfileView()
                    .environmentObject(goalRepository)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
