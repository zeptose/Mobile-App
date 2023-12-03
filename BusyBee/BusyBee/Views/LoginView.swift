//
//  LoginView.swift
//  BusyBee
//
//  Created by elaine wang on 11/1/23.
//

import SwiftUI

struct LoginFormView: View {
    @Binding var isLoggingIn: Bool
    @State private var isEnteringCredentials = false
    @State private var password = ""
    @State private var email = ""
    @Binding var selectedTab: Int
    @EnvironmentObject var viewModel: AuthViewModel
    let customMaroon = Color(UIColor(hex: "#992409"))


    
  var body: some View {
    ZStack {
      Image("HiveGraphic")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: UIScreen.main.bounds.width * 0.5)
        .position(x: UIScreen.main.bounds.width * 0.9, y: UIScreen.main.bounds.height * 0)
      
      Image("BeeGraphic")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: UIScreen.main.bounds.width * 0.4)
        .position(x: UIScreen.main.bounds.width * 0.7, y: UIScreen.main.bounds.height * 0.025)
      
      VStack {
        Text("BusyBee")
          .font(.system(size: 65, weight: .bold))
          .foregroundColor(customMaroon)
          .padding(.top, 40)

        
        Text("Login to your accont and\ncontinue your goal-achieving journey")
          .font(.system(size: 18))
          .foregroundColor(Color.gray)
          .multilineTextAlignment(.center)
          .padding(.bottom, 20)
        
        VStack(alignment: .leading, spacing: 30) {
          TextField("Email", text: $email)
            .padding()
            .overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(Color.gray))
          
          SecureField("Password", text: $password)
            .padding()
            .overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(Color.gray))
          
          HStack{
            
            Spacer()
            
            Button("Submit") {
              isLoggingIn.toggle()
              selectedTab = 3
              Task {
                try await viewModel.signIn(withEmail: email,
                                           password: password)
              }
            }
            .font(.system(size: 16))
            .foregroundColor(.white)
            .padding()
            .frame(width: UIScreen.main.bounds.width * 0.5)
            .background(customMaroon)
            .cornerRadius(100)
            //                    .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            
            Spacer()
          }
          
          Spacer()

        }
      }
      .padding()
    }
  }
}

extension LoginFormView: AuthenticationFormProtocol {
  var formIsValid: Bool {
    return !email.isEmpty
    && email.contains("@")
    && !password.isEmpty
    && password.count > 5
  }
}
