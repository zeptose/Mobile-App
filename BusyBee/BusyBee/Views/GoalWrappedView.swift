//
//  GoalWrappedView.swift
//  BusyBee
//
//  Created by Joyce Huang on 12/9/23.
//

import SwiftUI
//import iCarousel

struct GoalWrappedView: View {
    @EnvironmentObject var postController: PostController
    @EnvironmentObject var cameraController: CameraController
    @EnvironmentObject var goalController: GoalController
    let customYellow = Color(UIColor(hex: "#FEC500"))
    let customMaroon = Color(UIColor(hex: "#992409"))
    var goal: Goal
    var user: User
  
    
    var body: some View {
        let completedPosts = postController.getPostsForGoal(goalId: goal.id)
        let pSize: CGFloat = completedPosts.count > 1 ? -40 : -130
        let pSize2: CGFloat = completedPosts.count > 1 ? 0 : 50
        ZStack {
            Image("GoalWrappedBg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    HStack{
                        Image("profilePic")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(customYellow, lineWidth: 3))
                        Text("\(user.username)")
                            .foregroundColor(.black)
                    }.padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 10))
                    Text("\(goal.name)")
                        .font(.title)
                        .bold()
                    let dateFormatter: DateFormatter = {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "MM/dd/yy"
                        return formatter
                    }()
                    let startDateString = dateFormatter.string(from: goal.dateStarted)
                    let endDateString = dateFormatter.string(from: goal.dateEnded!)
                    Text("\(startDateString) - \(endDateString)")
                        .font(.headline)
                        .fontWeight(.regular)
                        .padding(.top, 1)
                }
               .frame(height: 60)
               .padding()
//                iCarousel(items: postController.getPostsForGoal(goalId: goal.id), id: \.id) { post in
//                                VStack(spacing: 15) {
//                                    Image(uiImage: postController.getImageFromURL(url: post.photo))
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fill)
//                                        .frame(width: 120, height: 100)
//                                        .clipShape(Hexagon())
//                                }
//                            }
//                            .carouselOptions(LinearCarouselOptions())
            
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: -25) {
                        ForEach(postController.getPostsForGoal(goalId: goal.id).indices, id: \.self) { index in
                            let post = postController.getPostsForGoal(goalId: goal.id)[index]
                            if index % 2 == 0 {
                                Image(uiImage: postController.getImageFromURL(url: post.photo))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 160, height: 140)
                                    .clipShape(Hexagon())
                                    .overlay(
                                        Hexagon()
                                            .stroke(customYellow, lineWidth: 15)
                                    )
                                
                            }
                            else {
                                Image(uiImage: postController.getImageFromURL(url: post.photo))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 160, height: 140)
                                    .clipShape(Hexagon())
                                    .overlay(
                                        Hexagon()
                                            .stroke(customYellow, lineWidth: 15)
                                    )
                                    .padding(.top, 140)
                                
                            }
                        }
                    }
                }
                .padding(.top, pSize2)
                HStack {
                    Image("HeartBeeRight")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                    VStack {
                        let numGoals =  goalController.getPastGoals(currentUser: user).count
                        Text("Congrats on completing")
                            .font(.headline)
                            .padding(.top, 15)
                        HStack {
                            Text("your")
                                .font(.headline)
                                .padding(.trailing, -2)
                            Text("\(numGoals)")
                                .font(.headline)
                                .foregroundColor(customMaroon)
                            
                            if numGoals == 1 {
                                Text("st")
                                    .font(.headline)
                                    .foregroundColor(customMaroon)
                                    .padding(.leading, -8)
                            } else if numGoals == 2 {
                                Text("nd")
                                    .font(.headline)
                                    .foregroundColor(customMaroon)
                                    .padding(.leading, -8)
                            } else if numGoals == 3 {
                                Text("rd")
                                    .font(.headline)
                                    .foregroundColor(customMaroon)
                                    .padding(.leading, -8)
                            } else {
                                Text("th")
                                    .font(.headline)
                                    .foregroundColor(customMaroon)
                                    .padding(.leading, -8)
                            }
                            Text("goal this year!")
                                .font(.headline)
                                .padding(.leading, -2)
                        }
                        let numPhotos = postController.getPostsForGoal(goalId: goal.id).count
                        let calendar = Calendar.current
                        let components = calendar.dateComponents([.day], from: goal.dateStarted, to: goal.dateEnded!)
                        let numDays = components.day ?? 0
                        let numReactions = postController.numReactions(goal: goal)
                        
                        Text("Photos Taken")
                            .font(.caption)
                            .padding(.top, 20)
                        Text("\(numPhotos)")
                            .font(.headline)
                            .padding(.bottom, 20)
                        Text("Days Spent").font(.caption)
                        Text("\(numDays)")
                            .font(.headline)
                            .padding(.bottom, 20)
                        Text("Reactions Received").font(.caption)
                        Text("\(numReactions)")
                            .font(.headline)
                            .padding(.bottom, 20)
                    }
                    Image("HeartBeeLeft")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .padding(.top, 250)
                }.padding(.top, -20)
                

                  Button(action: {
                      guard let screenshot = cameraController.captureScreen(),
                            let imageData = screenshot.jpegData(compressionQuality: 1.0) else {
                          return
                      }

                      // Save the screenshot to the camera roll
                      UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)

                      // Call the backend saving function
                      cameraController.savePhotoToBackend(imageData: imageData)
                  }) {
                
                      Text("Save")
                          .foregroundColor(.white)
                          .padding()
                          .background(Color(UIColor(hex: "#992409")))
                          .cornerRadius(8)
                  }
                  .padding()
            }.padding(.top, pSize)
              }
            }
            
        }
    


struct Hexagon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.width
        let height = rect.height

        // Define the points of the hexagon
        let points = [
            CGPoint(x: width * 0.25, y: 0),
            CGPoint(x: width * 0.75, y: 0),
            CGPoint(x: width, y: height * 0.5),
            CGPoint(x: width * 0.75, y: height),
            CGPoint(x: width * 0.25, y: height),
            CGPoint(x: 0, y: height * 0.5)
        ]

        path.addLines(points)

        // Close the path by adding a line to the starting point
        path.closeSubpath()

        return path
    }
}
