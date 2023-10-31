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
    @Binding var selectedTab: Int
    
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
            
            Spacer()
            
            if isEnteringCredentials {
                VStack {
                    TextField("Username", text: $username)
                        .padding()
                    
                    SecureField("Password", text: $password)
                        .padding()
                    
                    Button("Submit") {
                        isRegistering.toggle() // Set isRegistering to false
                        selectedTab = 4
                    }
                    .padding()
                }
            }
        }
        .padding()
    }
}
