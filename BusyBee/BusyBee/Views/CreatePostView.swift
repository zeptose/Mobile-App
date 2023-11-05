//
//  CreatePostView.swift
//  BusyBee
//
//  Created by Ryan McGrady on 11/3/23.
//

import SwiftUI

struct CreatePostView: View {
  var uiImage: UIImage // Assuming you're using UIImage for the captured image
  @State private var caption: String = ""
  @StateObject var camera: CameraController
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var viewModel: AuthViewModel
  @EnvironmentObject var goalController: GoalController
  @State private var uploadedImageURL: String = ""
  
  var body: some View {
    VStack(spacing: 20) {
      HStack {
        NavigationLink(destination: CameraView(camera: camera)) {
          Image(systemName: "arrow.left")
            .foregroundColor(.white)
            .padding()
            .font(.system(size: 30))
        }
        .padding(.leading, 0)
        Spacer()
      }
      .padding()
      
      GeometryReader { geometry in
        VStack(spacing: 20) {
          // Image
          Image(uiImage: uiImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: geometry.size.width, height: geometry.size.height * 0.65)
            .clipped()
          
          // Caption TextField
          TextField("Write a caption...", text: $caption)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
        }
        .onTapGesture {
          camera.capturedImage = nil
        }
      }
      .frame(maxHeight: .infinity)
      
      Spacer() // Add Spacer to push the share button to the bottom
      
      // Share Button
      Button(action: {
          uploadedImageURL = PostController().uploadPhoto(uiImage)

        if let currentUser = viewModel.currentUser {
                if let currentGoal = goalController.getCurrentGoal(currentUser: currentUser) {
                    PostController().addPost(
                        currentUser: currentUser,
                        goal: currentGoal,
                        caption: caption,
                        photo: uploadedImageURL,
                        subgoal: nil,
                        comments: [],
                        reactions: 0
                    )

                    // Print a message indicating that the post was successfully added
                    print("Post added successfully!")
                } else {
                    // Handle the case where there is no current goal for the user
                    print("No current goal available for the user.")
                }
            } else {
                // Handle the case where viewModel.currentUser is nil
                print("User is not logged in.")
            }
          
          // Dismiss the view after creating the post
          presentationMode.wrappedValue.dismiss()
      }) {
          Text("Share")
      }
      .padding()
    }
  }
}
