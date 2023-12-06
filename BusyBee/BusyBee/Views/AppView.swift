// ProfileView.swift
import SwiftUI

struct AppView: View {
  @EnvironmentObject var userController : UserController
  @EnvironmentObject var postController : PostController
  @EnvironmentObject var goalController: GoalController
  @EnvironmentObject var viewModel: AuthViewModel
  @EnvironmentObject var cameraController : CameraController
  
  @State private var showAlert = false
  
  @State var selectedTab: Int
  @State var navigateToHome = false
  
  var body: some View {
    TabView(selection: $selectedTab) {
      HomeView(user: viewModel.currentUser)
        .tabItem {
          Image(systemName: "house")
          Text("Home")
        }
        .tag(0)
      CameraView()
        .tabItem {
          Image(systemName: "camera")
          Text("Camera")
        }
        .tag(1)
      
      NotificationView()
        .tabItem {
          Image(systemName: "heart")
          Text("Notifications")
        }
        .tag(2)
      
      ProfileView(user: viewModel.currentUser)
        .tabItem {
          Image(systemName: "person")
          Text("Profile")
            .padding()
        }
        .tag(3)
    }
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden(true)
    .tint(.white)
    .onChange(of: selectedTab) { newTab in
      if newTab == 1 {
        if goalController.getCurrentGoals(currentUser: viewModel.currentUser!).isEmpty {
          showAlert = true
        }
      }
    }
    .alert(isPresented: $showAlert) {
      Alert(
        title: Text("No Goals"),
        message: Text("You don't have any goals. Please add goals before using the Camera."),
        dismissButton: .default(Text("OK"))
      )
      
    }
  }
}
