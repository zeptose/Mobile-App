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
    @State private var selectedSubgoal: Subgoal? = nil

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                NavigationLink(destination: CameraView(camera: camera)) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .padding()
                        .font(.system(size: 30))
                }
                .padding(.leading, 0).navigationBarBackButtonHidden(true)
                Spacer()
            }
            .padding()

            GeometryReader { geometry in
                VStack(spacing: 20) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.75) // Reduced image size
                        .clipped()
                        .offset(y: -20) // Adjusted vertical offset
                }
                .onTapGesture {
                    
                    camera.capturedImage = nil
                }
            }
            .frame(maxHeight: .infinity)
          
            TextField("Write a caption...", text: $caption)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .offset(y: -80) // Increased vertical offset for caption

            VStack(alignment: .leading) { // Styled ScrollView containers
                Text("Select Main Goal")
                    .font(.headline)
                    .foregroundColor(.blue) // Changed text color
                    .padding(.bottom, 4) // Added bottom padding

                ScrollView {
                    ForEach(goalController.getCurrentGoals(currentUser: viewModel.currentUser!), id: \.id) { goal in
                        Button(action: {
                            selectedGoal = goal
                            selectedSubgoal = nil // Reset selected subgoal
                        }) {
                            Text(goal.name)
                                .padding()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .frame(maxHeight: 150)
                .background(Color.gray.opacity(0.2)) // Styled background

                if let selectedGoal = selectedGoal {
                    Text("Select Sub Goals")
                        .font(.headline)
                        .foregroundColor(.blue) // Changed text color
                        .padding(.bottom, 4) // Added bottom padding

                    ScrollView {
                        ForEach(selectedGoal.subgoals, id: \.id) { subgoal in
                            Button(action: {
                                selectedSubgoal = subgoal
                            }) {
                                Text(subgoal.name)
                                    .padding()
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .frame(maxHeight: 150)
                    .background(Color.gray.opacity(0.2)) // Styled background
                }

                Button(action: {
                    guard let selectedGoal = selectedGoal else {
                        // Handle the case where no goal is selected
                        return
                    }

                    guard let selectedSubgoal = selectedSubgoal else {
                        // Handle the case where no subgoal is selected
                        return
                    }

                    uploadedImageURL = PostController().uploadPhoto(uiImage)

                    if let currentUser = viewModel.currentUser {
                        PostController().addPost(
                            currentUser: currentUser,
                            goal: selectedGoal,
                            caption: caption,
                            photo: uploadedImageURL,
                            subgoalId: selectedSubgoal.id,
                            comments: [],
                            reactions: 0
                        )

                        print("Post added successfully!")
                    } else {
                        print("User is not logged in.")
                    }
                }) {
                    Text("Share")
                }
                .padding()
            }
            .padding(.horizontal) // Added horizontal padding

            Spacer()
        }
        .onDisappear {
            camera.capturedImage = nil
        }
    }
}
