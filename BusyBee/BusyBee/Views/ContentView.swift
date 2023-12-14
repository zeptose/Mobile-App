// ContentView.swift
// BusyBee
// Created by elaine wang on 10/24/23.

// ContentView.swift
import SwiftUI

struct ContentView: View {
    @State private var isRegistering = true
    @State private var isLoggingIn = true
    @State private var selectedTab = 3 
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var userController: UserController
    @EnvironmentObject var postController: PostController
    @EnvironmentObject var goalController: GoalController
    @EnvironmentObject var cameraController: CameraController
    
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
                        .font(Font.custom("Quicksand-Regular", size: 18))
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.center) // Center the text
                        .padding(.bottom, 50)
                      
                      Spacer()
                      
                      NavigationLink(destination: RegistrationFormView(isRegistering: $isRegistering, selectedTab: $selectedTab)
                      ) {
                        Text("Register")
                          .font(Font.custom("Quicksand-Regular", size: 16))
                          .foregroundColor(.white)
                          .padding()
                          .frame(width: UIScreen.main.bounds.width * 0.5)
                          .background(customMaroon)
                          .cornerRadius(100)
                          .padding(.bottom, 8)
                        
                      }
                      NavigationLink(destination: LoginFormView(isLoggingIn: $isLoggingIn, selectedTab: $selectedTab)) {
                        Text("Login")
                          .font(Font.custom("Quicksand-Regular", size: 16))
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
            AppView(selectedTab: 3)
              .environmentObject(userController)
              .environmentObject(postController)
              .environmentObject(goalController)
              .environmentObject(viewModel)
              .environmentObject(cameraController)
              .environment(\.font, Font.custom("Quicksand-Regular", size: 16))

                  
          }
        }
    }

}
