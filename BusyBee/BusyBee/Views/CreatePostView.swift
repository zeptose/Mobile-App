//
//  CreatePostView.swift
//  BusyBee
//
//  Created by Ryan McGrady on 11/3/23.
//

import SwiftUI

struct CreatePostView: View {
    var uiImage: UIImage
    @State private var caption: String = ""
    @StateObject var camera: CameraController
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var goalController: GoalController
    @State private var uploadedImageURL: String = ""
    @State private var selectedGoal: Goal? = nil

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
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.65)
                        .clipped()

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

            Spacer()

            VStack {
                Text("Select Main Goal")
                    .font(.headline)
                    .padding()

                ScrollView {
                    ForEach(goalController.getCurrentGoals(currentUser: viewModel.currentUser!), id: \.id) { goal in
                        Button(action: {
                            selectedGoal = goal
                        }) {
                            Text(goal.name)
                                .padding()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .frame(maxHeight: 150)

                Button(action: {
                    guard let selectedGoal = selectedGoal else {
                        // Handle the case where no goal is selected
                        return
                    }

                    uploadedImageURL = PostController().uploadPhoto(uiImage)

                    if let currentUser = viewModel.currentUser {
                        PostController().addPost(
                            currentUser: currentUser,
                            goal: selectedGoal,
                            caption: caption,
                            photo: uploadedImageURL,
                            subgoalId: nil,
                            comments: [],
                            reactions: 0
                        )

                        print("Post added successfully!")
                    } else {
                        print("User is not logged in.")
                    }

                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Share")
                }
                .padding()
            }
        }
    }
}
