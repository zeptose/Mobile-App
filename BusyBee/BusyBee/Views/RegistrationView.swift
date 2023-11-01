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
    
    var body: some View {
        VStack {
            Text("BusyBee")
                .font(.largeTitle)
                .foregroundColor(Color.yellow)
                .padding(.top, 20)
            
            Spacer()
            
            Button("Register") {
                isEnteringCredentials.toggle()
            }
            .font(.title)
            .foregroundColor(Color.blue)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: 2)
            )
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            
            Spacer()
            
            if isEnteringCredentials {
                VStack {
                    TextField("Email", text: $email)
                      .padding()
                  
                    TextField("Username", text: $username)
                        .padding()
                    
                    SecureField("Password", text: $password)
                        .padding()
                  
                    SecureField("Confirm Password", text: $confirmpassword)
                      .padding()
                    
                    Button("Submit") {
                        isRegistering.toggle() // Set isRegistering to false
                        selectedTab = 4
                      Task {
                        try await viewModel.createUser(withEmail: email,
                                                      password: password,
                                                      username: username)
                      }
                    }
                    .padding()
                }
            }
        }
        .padding()
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
