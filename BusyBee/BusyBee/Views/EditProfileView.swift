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
            VStack(alignment: .leading) {
                Text("Username").font(Font.custom("Quicksand-Bold", size: 20))
                Text("Change your username.").font(Font.custom("Quicksand-Regular", size: 16)).foregroundColor(.gray)
                TextField("Enter Username", text: $username)
                    .padding(10)
                    .background(
                          RoundedRectangle(cornerRadius: 15)

                                  .strokeBorder(Color(UIColor(hex: "#9DB2CE")), lineWidth: 2)
                          )
                Text("Bio").font(Font.custom("Quicksand-Bold", size: 20))
                Text("Change your profile bio.").font(Font.custom("Quicksand-Regular", size: 16)).foregroundColor(.gray)
                TextField("Enter Bio", text: $bio)
                    .padding(10)
                    .background(
                          RoundedRectangle(cornerRadius: 15)

                                  .strokeBorder(Color(UIColor(hex: "#9DB2CE")), lineWidth: 2)
                          )
                Spacer()
            }.padding(20)
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
