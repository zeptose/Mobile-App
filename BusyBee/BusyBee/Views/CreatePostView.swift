//
//  CreatePostView.swift
//  BusyBee
//
//  Created by Ryan McGrady on 10/31/23.
//

// CreatePostView.swift.swift

// CreatePostView.swift
import SwiftUI

struct CreatePostView: View {
    var uiImage: UIImage
    @State private var caption: String = ""
    @EnvironmentObject var camera: CameraController
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var goalController: GoalController
    @EnvironmentObject var postController: PostController
    @State private var uploadedImageURL: String = ""
    @State private var selectedGoalIndex: Int = 0
    @State private var selectedSubgoalIndex: Int = 0
    @State private var navigateToHome = false

    var selectedGoal: Goal? {
        goalController.getCurrentGoals(currentUser: viewModel.currentUser!)[selectedGoalIndex]
    }

    var selectedSubgoal: Subgoal? {
        selectedGoal?.subgoals[selectedSubgoalIndex]
    }

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                NavigationLink(destination: CameraView()) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.blue)
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
                        .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.65)
                        .clipped()
                }
            }
            .frame(maxHeight: .infinity)

            TextField("Write a caption...", text: $caption)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .offset(y: -100)

            VStack(alignment: .leading) {
                Text("Select Main Goal")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding(.bottom, 4)

                Picker(selection: $selectedGoalIndex, label: Text("Main Goal")) {
                    ForEach(0..<goalController.getCurrentGoals(currentUser: viewModel.currentUser!).count, id: \.self) { index in
                        Text(goalController.getCurrentGoals(currentUser: viewModel.currentUser!)[index].name)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .background(Color.gray.opacity(0.2))
                .padding(.bottom, 20)

                if let selectedGoal = selectedGoal {
                    Text("Select Sub Goals")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding(.bottom, 4)

                    Picker(selection: $selectedSubgoalIndex, label: Text("Sub Goal")) {
                        ForEach(0..<selectedGoal.subgoals.count, id: \.self) { index in
                            Text(selectedGoal.subgoals[index].name)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .background(Color.gray.opacity(0.2))
                    .padding(.bottom, 20)
                }

                Button(action: {
                    guard let selectedGoal = selectedGoal else {
                        return
                    }

                    guard let selectedSubgoal = selectedSubgoal else {
                        return
                    }

                    uploadedImageURL = postController.uploadPhoto(uiImage)
                    if let currentUser = viewModel.currentUser {
                        postController.addPost(
                            currentUser: currentUser,
                            goal: selectedGoal,
                            caption: caption,
                            photo: uploadedImageURL,
                            subgoalId: selectedSubgoal.id,
                            comments: [],
                            reactions: 0
                        )

                        print("Post added successfully!")
                        navigateToHome = true
                        presentationMode.wrappedValue.dismiss()
  
                    } else {
                        print("User is not logged in.")
                    }
                }) {
                    Text("Share")
                }
                .padding()
                 .frame(maxWidth: .infinity)
                 .background(Color.blue)
                 .foregroundColor(.white)
                 .cornerRadius(10)
                 Spacer()

            }

                NavigationLink(
                  destination: AppView(selectedTab : 0).navigationBarHidden(true),
                    isActive: $navigateToHome
                ) {
                    EmptyView()
                }
                .opacity(0)
                .frame(width: 0, height: 0)
            
        }
    }
}
