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

    
    var body: some View {
        VStack {
            Text("BusyBee")
                .font(.largeTitle)
                .foregroundColor(Color.yellow)
                .padding(.top, 20)
            Spacer()

              VStack {
                    TextField("Email", text: $email)
                      .padding()
                    
                    SecureField("Password", text: $password)
                        .padding()
                  
                    Button("Submit") {
                        isLoggingIn.toggle()
                        selectedTab = 4
                      Task {
                        try await viewModel.signIn(withEmail: email,
                                                   password: password)
                      }
                    }
                    .padding()
//                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.5)
                }
        }
        .padding()
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
