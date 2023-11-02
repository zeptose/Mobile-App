// ProfileView.swift
import SwiftUI

struct AppView: View {
    @EnvironmentObject var goalRepository: GoalRepository
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var selectedTab = 4 
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Home")
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            
            Text("Search")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(1)
            
            Text("Images")
                .tabItem {
                    Image(systemName: "photo")
                    Text("Images")
                }
                .tag(2)
            
            Text("Calendar")
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
                .tag(3)
            
            ProfileView()
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
            .environmentObject(GoalRepository())
    }
}
