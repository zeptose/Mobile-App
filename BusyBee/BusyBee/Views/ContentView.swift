// ContentView.swift
// BusyBee
// Created by elaine wang on 10/24/23.

// ContentView.swift
import SwiftUI

struct ContentView: View {
    @State private var isRegistering = true
    @State private var isLoggingIn = true
    @State private var selectedTab = 4 // Assuming "Profile" is the 5th tab (index 4)
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var userController: UserController
    @EnvironmentObject var postController: PostController
    @EnvironmentObject var goalController: GoalController
    let customMaroon = Color(UIColor(hex: "#992409"))
  
  @State private var beeOffset: CGFloat = 0
  @State private var moveUp = true
  
    var body: some View {
        NavigationView {
            if viewModel.userSession == nil {
                NavigationView {
                  ZStack {
                    // Background Image
                    Image("HiveGraphic")
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                      .frame(width: UIScreen.main.bounds.width * 0.8)
                      .padding(.top, -375)
                    
                    Image("BeeGraphic")
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                      .frame(width: UIScreen.main.bounds.width * 0.5)
                      .padding(.top, -275)
                      .offset(y: beeOffset)
                      .onAppear {
                        withAnimation(Animation.easeInOut(duration: 1).repeatForever()) {
                          beeOffset = moveUp ? -20 : 20
                          moveUp.toggle()
                        }
                      }
                    VStack {
                      Text("BusyBee")
                        .font(.system(size: 65, weight: .bold)) // Bigger and bolded font
                        .foregroundColor(customMaroon)
                        .padding(.top, 150)
                      
                      Text("Set and achieve your goals\nalongside your friends!") // Line break for the caption
                        .font(.system(size: 18)) // Slightly bigger font
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.center) // Center the text
                        .padding(.bottom, 50)
                      
                      Spacer()
                      
                      NavigationLink(destination: RegistrationFormView(isRegistering: $isRegistering, selectedTab: $selectedTab)
                      ) {
                        Text("Register")
                          .font(.system(size: 16))
                          .foregroundColor(.white)
                          .padding()
                          .frame(width: UIScreen.main.bounds.width * 0.5)
                          .background(customMaroon)
                          .cornerRadius(100)
                          .padding(.bottom, 8)
                        
                      }
                      NavigationLink(destination: LoginFormView(isLoggingIn: $isLoggingIn, selectedTab: $selectedTab)) {
                        Text("Login")
                          .font(.system(size: 16))
                          .foregroundColor(.white)
                          .padding()
                          .frame(width: UIScreen.main.bounds.width * 0.5)
                          .background(customMaroon)
                          .cornerRadius(100)
                      }
                      
                      Spacer()
                    }
                  }
                }
            } else {
                AppView()
                    .environmentObject(userController)
                    .environmentObject(postController)
                    .environmentObject(goalController)
                    .environmentObject(viewModel)
                    .environment(\.font, Font.custom("Lato-Regular", size: 16))
            }
        }
    }
      

}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
