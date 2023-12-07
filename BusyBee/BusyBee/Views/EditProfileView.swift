//
//  EditProfileView.swift
//  BusyBee
//
//  Created by elaine wang on 11/7/23.
//

import SwiftUI

struct EditProfileView: View {
    var user: User
    @State private var username: String = ""
    @State private var bio: String = ""
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var userController: UserController

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit Profile Details")) {
                    TextField("Username", text: $username)
                    TextField("Update your Bio", text: $bio)
                }
                // Add more editable fields here
            }
            .navigationTitle("Edit Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        userController.updateProfile(user: user, username: username, bio: bio)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
