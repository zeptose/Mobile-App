// ProfileView.swift
import SwiftUI

struct AppView: View {
    @EnvironmentObject var goalRepository: GoalRepository
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var selectedTab = 4
    let userController = UserController()
    @State private var isShowingCamera = false
//    @StateObject private var cameraController = CameraController()

    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Home")
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

//            CameraView(camera: cameraController)
//                .tabItem {
//                    Image(systemName: "camera")
//                    Text("Camera")
//                }
//                .tag(2)

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
    }
}


struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
