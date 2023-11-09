// ProfileView.swift
import SwiftUI

struct AppView: View {
    @EnvironmentObject var userController : UserController
    @EnvironmentObject var postController : PostController
    @EnvironmentObject var goalController: GoalController
    @EnvironmentObject var viewModel: AuthViewModel
<<<<<<< HEAD
//    @EnvironmentObject var cameraController : CameraController
  
    @State private var selectedTab = 4
    @State private var isShowingCamera = false
=======
    @EnvironmentObject var cameraController : CameraController
    @State private var showAlert = false
    
    @State var selectedTab: Int
    @State var navigateToHome = false
>>>>>>> 8c864946c23ff38e52410b736eab0af96edd99e7
    
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
<<<<<<< HEAD

//            CameraView()
//                .tabItem {
//                    Image(systemName: "camera")
//                    Text("Camera")
//                }
//                .tag(2)

            Text("Calendar")
=======
            CameraView()
                .tabItem {
                    Image(systemName: "camera")
                    Text("Camera")
                }
                .tag(2)
            
            CalendarView()
>>>>>>> 8c864946c23ff38e52410b736eab0af96edd99e7
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
<<<<<<< HEAD
        }.navigationBarTitleDisplayMode(.inline)
//            .environmentObject(userController)
//            .environmentObject(goalController)
//            .environmentObject(postController)
            .navigationBarBackButtonHidden(true)
    }
}


struct AppView_Previews: PreviewProvider {
    static var previews: some View {
      ZStack{
        AppView()
      }

=======
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .onChange(of: selectedTab) { newTab in
            if newTab == 2 { 
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
>>>>>>> 8c864946c23ff38e52410b736eab0af96edd99e7
    }
}
