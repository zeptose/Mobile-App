// ProfileView.swift
import SwiftUI

struct AppView: View {
    @EnvironmentObject var userController : UserController
    @EnvironmentObject var postController : PostController
    @EnvironmentObject var goalController: GoalController
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var cameraController : CameraController
  
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
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(1)

            CameraView()
                .tabItem {
                    Image(systemName: "camera")
                    Text("Camera")
                }
                .tag(2)

            Text("Calendar")
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
                .tag(3)

            ProfileView(user: viewModel.currentUser)
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                    .padding()
                }
                .tag(4)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)

    }
}

