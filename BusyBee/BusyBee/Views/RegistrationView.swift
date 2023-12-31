//
//  RegistrationView.swift
//  BusyBee
//
//  Created by Ryan McGrady on 10/31/23.
//

// RegistrationFormView.swift
import SwiftUI

struct RegistrationFormView: View {
    @Binding var isRegistering: Bool
    @State private var isEnteringCredentials = false
    @State private var username = ""
    @State private var password = ""
    @State private var confirmpassword = ""
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
        
        Text("Join your friends and\nstart your goal-achieving journey")
          .font(.system(size: 18))
          .foregroundColor(Color.gray)
          .multilineTextAlignment(.center)
          .padding(.bottom, 20)
        
        VStack(alignment: .leading, spacing: 20) {
          TextField("Email", text: $email)
            .padding()
            .overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(Color.gray))
          
          TextField("Username", text: $username)
            .padding()
            .overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(Color.gray))
          
          SecureField("Password", text: $password)
            .padding()
            .overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(Color.gray))
          
          SecureField("Confirm Password", text: $confirmpassword)
            .padding()
            .overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(Color.gray))
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        
        Spacer()
        
        Button(action: {
          isRegistering.toggle()
          selectedTab = 3
          Task {
            try await viewModel.createUser(withEmail: email, password: password, username: username)
          }
        }) {
          Text("Submit")
            .font(.system(size: 16))
            .foregroundColor(.white)
            .padding()
            .frame(width: UIScreen.main.bounds.width * 0.5)
            .background(customMaroon)
            .cornerRadius(100)
        }
        .padding()
        .disabled(!formIsValid)
        
        Spacer()
        
        //            NavigationLink(destination: LoginView()) {
        Text("Have an account? Login here")
          .foregroundColor(Color.blue)
        //            }

      }.font(Font.custom("Quicksand-Regular", size: 16))
      .padding()
      
      
    }
  }
}

extension RegistrationFormView: AuthenticationFormProtocol {
  var formIsValid: Bool {
    return !email.isEmpty
    && email.contains("@")
    && !password.isEmpty
    && password.count > 5
    && !username.isEmpty
    && password == confirmpassword
  }
}
