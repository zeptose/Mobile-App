//
//  CreatePostView.swift
//  BusyBee
//
//  Created by Ryan McGrady on 10/31/23.
//

// CreatePostView.swift.swift

// CreatePostView.swift
import SwiftUI

struct GoalListView: View {
    @Binding var selectedGoalIndex: Int
    var goals: [Goal]
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedGoals: [Goal] // Add binding for selectedGoals
    
    var body: some View {
        List {
            ForEach(0..<goals.count, id: \.self) { index in
                Text(goals[index].name)
                    .onTapGesture {
                        selectedGoalIndex = index
                        selectedGoals.append(goals[index]) // Append selected goal to selectedGoals
                        presentationMode.wrappedValue.dismiss()
                    }
            }
        }
    }
}

struct SubgoalListView: View {
    @Binding var selectedSubgoalIndex: Int
    var subgoals: [Subgoal]
  @ Environment(\.presentationMode) var presentationMode
    @Binding var selectedSubgoals: [Subgoal] // Add binding for selectedSubgoals
    
    var body: some View {
        List {
            ForEach(0..<subgoals.count, id: \.self) { index in
                Text(subgoals[index].name)
                    .onTapGesture {
                        selectedSubgoalIndex = index
                        selectedSubgoals.append(subgoals[index]) // Append selected subgoal to selectedSubgoals
                        presentationMode.wrappedValue.dismiss()
                    }
            }
        }
    }
}


struct CreatePostView: View {
  var uiImage: UIImage
  @State private var caption: String = ""
  @EnvironmentObject var camera: CameraController
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var viewModel: AuthViewModel
  @EnvironmentObject var goalController: GoalController
  @EnvironmentObject var postController: PostController
  @State private var uploadedImageURL: String = ""
  @State private var selectedGoalIndex: Int = -1
  @State private var selectedSubgoalIndex: Int = -1
  @State private var navigateToHome = false
  @State private var isShowingGoalList = false
  @State private var isShowingSubgoalList = false
  @State private var selectedGoals: [Goal] = []
  @State private var selectedSubgoals: [Subgoal] = []
  
  
  
  var selectedGoal: Goal? {
    guard selectedGoalIndex >= 0 else{
      return nil
    }
    return goalController.getCurrentGoals(currentUser: viewModel.currentUser!)[selectedGoalIndex]
  }
  
  var selectedSubgoal: Subgoal? {
    guard selectedSubgoalIndex >= 0 else {
      return nil
    }
    return goalController.getSubgoalsForGoal(goal: selectedGoal!)[selectedSubgoalIndex]
  }
  
  var body: some View {
    VStack {
      HStack {
        Button(action: {
          camera.capturedImage = nil
        }) {
          Image(systemName: "chevron.backward")
            .foregroundColor(.black)
            .padding()
            .font(.system(size: 30))
        }
        .padding(.leading, 0)
        
        Spacer()
        Spacer()
        Spacer()
        
        Text("Share")
            .foregroundColor(Color(UIColor(hex: "#992409")))
            .font(.system(size: 16, weight: .bold))
            .onTapGesture {
                guard let selectedGoal = selectedGoal else {
                    return
                }
                
                var subgoalidval: String? = nil
                if let selectedSubgoal = selectedSubgoal {
                    subgoalidval = selectedSubgoal.id
                }
                else {
                    subgoalidval = "-1"
                }
                
                uploadedImageURL = postController.uploadPhoto(uiImage)
                if let currentUser = viewModel.currentUser {
                    postController.addPost(
                        currentUser: currentUser,
                        goal: selectedGoal,
                        caption: caption,
                        photo: uploadedImageURL,
                        subgoalId: subgoalidval
                    )
                    print("Post added successfully!")
                    
                    navigateToHome = true
                    presentationMode.wrappedValue.dismiss()
                } else {
                    print("User is not logged in.")
                }
            }
        .overlay(
          NavigationLink(
            destination: AppView(selectedTab : 0).navigationBarHidden(true),
            isActive: $navigateToHome
          ) {
            EmptyView()
          }
          .opacity(0)
          .frame(width: 0, height: 0)
        )
        
      }.zIndex(1).padding()
      
  

      GeometryReader { geometry in
        VStack {
          Image(uiImage: uiImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.45)
            .clipped()
            .padding(.horizontal, (geometry.size.width * 0.05))
          
          TextField("Write a caption...🐝", text: $caption)
            .textFieldStyle(DefaultTextFieldStyle())
            .background(Color.white) // Set the background color to white
            .cornerRadius(8)
            .offset(x: 20)
            .padding()
          
        
          Spacer().frame(height: 200)
        
      
              HStack {
                Text("Main Goal")
                  .font(.headline)
                  .foregroundColor(.black)
                  .offset(x: 30)
                
                Spacer()
                
                if selectedGoals.isEmpty {
                  Text("Add")
                    .foregroundColor(Color(UIColor(hex: "#992409")))
                    .font(.system(size: 16, weight: .bold)) // Adjust size and weight as needed
                    .padding(.leading, -5) // Negative padding moves the text to the left
                    .onTapGesture {
                      isShowingGoalList = true
                    }
                    .sheet(isPresented: $isShowingGoalList) {
                      GoalListView(selectedGoalIndex: $selectedGoalIndex, goals: goalController.getCurrentGoals(currentUser: viewModel.currentUser!), selectedGoals: $selectedGoals)
                    }
                }
              }.padding(.trailing).offset(y: -130)
              
              
              ForEach(selectedGoals, id: \.self) { goal in
                ZStack {
                  RoundedRectangle(cornerRadius: 15)
                    .fill(Color.yellow)
                    .frame(height: 30)
                  
                  HStack {
                    Text(goal.name)
                    Button(action: {
                      if let index = selectedGoals.firstIndex(of: goal) {
                        selectedGoals.remove(at: index)
                      }
                    }) {
                      Image(systemName: "minus.circle")
                        .foregroundColor(.red)
                    }
                  }
                  .padding(.horizontal, 20)
                  
                  
                }
                .frame(height: 30)
                .padding(.horizontal)
                .offset(y: -120)
                
              }

            VStack{
                HStack {
                  
                  Text("Subgoals")
                    .font(.headline)
                    .foregroundColor(.black)
                    .offset(x: 30)
                  
                  Spacer()
                  
                  if selectedSubgoals.isEmpty {
                    Text("Add")
                        .foregroundColor(Color(UIColor(hex: "#992409")))
                        .font(.system(size: 16, weight: .bold)) // Adjust size and weight as needed
                        .padding(.leading, -5) // Negative padding moves the text to the left
                        .onTapGesture {
                          isShowingSubgoalList = true
                        }
                    .sheet(isPresented: $isShowingSubgoalList) {
                      if let selectedGoal = selectedGoal {
                        SubgoalListView(selectedSubgoalIndex: $selectedSubgoalIndex, subgoals: goalController.getSubgoalsForGoal(goal: selectedGoal), selectedSubgoals: $selectedSubgoals)
                      } else {
                        Text("No goal selected") // Placeholder view or action when no goal is selected
                      }
                    }
                  }
              }
            }.padding(.trailing).offset(y: -100)
            
            
            
            
            ForEach(selectedSubgoals, id: \.self) { subgoal in
              ZStack {
                RoundedRectangle(cornerRadius: 15)
                  .fill(Color.yellow)
                  .frame(height: 30)
                
                HStack {
                  Text(subgoal.name)
                  Button(action: {
                    if let index = selectedSubgoals.firstIndex(of: subgoal) {
                      selectedSubgoals.remove(at: index)
                    }
                  }) {
                    Image(systemName: "minus.circle")
                      .foregroundColor(.red)
                  }
                }
                .padding(.horizontal, 10)
                
                
              }
              .frame(height: 30)
              .padding(.horizontal)
              .offset(y: -80)
            }
            }
          }
        }
      }
    }
  
