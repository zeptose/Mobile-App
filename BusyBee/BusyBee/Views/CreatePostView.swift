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
  let fieldPadding = EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
  
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
                .foregroundColor(Color(UIColor(hex:"#F08355")))
            .padding()
            .font(.system(size: 30))
        }
        .padding(.leading, 0)
        
        Spacer()
        Spacer()
        Spacer()
        
        Text("Share")
            
            .font(Font.custom("Quicksand-Bold", size: 16))
            .foregroundColor(.white)
            .padding(10)
            
            .background(Color(UIColor(hex: "#992409")))
            .cornerRadius(8)
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
        
      }.zIndex(1).padding(.horizontal, 20).padding(.vertical, -4)

      
  

      GeometryReader { geometry in
        VStack {
          Image(uiImage: uiImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.45)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, (geometry.size.width * 0.05))
          
            TextField("Write a caption...🐝", text: $caption)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                
                                    .strokeBorder(Color(UIColor(hex: "#9DB2CE")), lineWidth: 2)
                            ).padding(fieldPadding)
        
          Spacer().frame(height: 50)
        
      
            VStack(alignment: .leading) {
                Text("Main Goal")
                  .font(Font.custom("Quicksand-Bold", size: 20))
                  .foregroundColor(.black)
                  .frame(alignment: .leading)
                if selectedGoals.isEmpty {
                    HStack {
                        Text("Tag Goal")
                            .font(Font.custom("Quicksand-Regular", size: 16))
                            .foregroundColor(.gray)
                        Spacer()
                        Image(systemName: "plus")
                        .foregroundColor(.gray)
                    }
                    .padding(8)
                    .background(Color(UIColor(hex: "#E0E0E0"))).opacity(1)
                    .cornerRadius(8)
                    .onTapGesture {
                      isShowingGoalList = true
                    }
                    .sheet(isPresented: $isShowingGoalList) {
                      GoalListView(selectedGoalIndex: $selectedGoalIndex, goals: goalController.getCurrentGoals(currentUser: viewModel.currentUser!), selectedGoals: $selectedGoals)
                    }
                }
              }.padding(10)
              
              
              ForEach(selectedGoals, id: \.self) { goal in
                  HStack {
                    Text(goal.name)
                      .autocapitalization(.words)
                      .padding(.leading, 10)
                      .padding(.vertical, 5)
                      .lineLimit(1)
                      .background(
                        RoundedRectangle(cornerRadius: 8)
                          .fill(Color(UIColor(hex: "#E0E0E0")))
                          .frame(width: UIScreen.main.bounds.width * 0.5)
                          .padding(.leading, 10)
                      )
                      
                      .padding(10)
                      Spacer()
                    
                    Button(action: {
                      if let index = selectedGoals.firstIndex(of: goal) {
                        selectedGoals.remove(at: index)
                      }
                    }) {
                      Image(systemName: "xmark")
                        .foregroundColor(.black)
                    }
                  }
                  
              }

            VStack(alignment: .leading){
                  Text("Milestones")
                    .font(Font.custom("Quicksand-Bold", size: 20))
                    .foregroundColor(.black)
                    .frame(alignment: .leading)
                 
                  if selectedSubgoals.isEmpty {
                      HStack {
                          Text("Tag Milestone")
                              .font(Font.custom("Quicksand-Regular", size: 16))
                              .foregroundColor(.gray)
                          Spacer()
                          Image(systemName: "plus")
                          .foregroundColor(.gray)
                      }
                      .padding(8)
                      .background(Color(UIColor(hex: "#E0E0E0"))).opacity(1)
                      .cornerRadius(8)
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
              
            }.padding(10)
            
            
            
            
            ForEach(selectedSubgoals, id: \.self) { subgoal in
              ZStack {
                
                
                HStack {
                    Text(subgoal.name)
                      .autocapitalization(.words)
                      .padding(.leading, 10)
                      .padding(.vertical, 5)
                      .lineLimit(1)
                      .background(
                        RoundedRectangle(cornerRadius: 8)
                          .fill(Color(UIColor(hex: "#E0E0E0")))
                          .frame(width: UIScreen.main.bounds.width * 0.5)
                          .padding(.leading, 10)
                      )
                      
                      .padding(10)
                  Button(action: {
                    if let index = selectedSubgoals.firstIndex(of: subgoal) {
                      selectedSubgoals.remove(at: index)
                    }
                  }) {
                    Image(systemName: "xmark")
                      .foregroundColor(.black)
                  }
                }
              }
            }
            }
          }
        }
      }
    }
  
