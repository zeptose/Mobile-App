//
//  IndividualGoalView.swift
//  BusyBee
//
//  Created by Joshua Yu  on 11/6/23.
//

import SwiftUI

struct IndividualGoalView: View {
    var goal: Goal
    @EnvironmentObject var postController: PostController
    @EnvironmentObject var goalController: GoalController
    @EnvironmentObject var userController: UserController
    @Environment(\.presentationMode) var presentationMode
    @State private var rectangleHeight: CGFloat = 100
    @State private var isShowingSubgoals: Bool = false
    let customYellow = Color(UIColor(hex: "#FFD111"))

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16)
                    .padding(.leading, 5)
                }
              
                Spacer()
                Image("profilePic")
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 30, height: 30)
                  .clipShape(Circle())
                  .overlay(Circle().stroke(customYellow, lineWidth: 3))
                if let goalUser = userController.getUserFromId(userId: goal.userId) {
                  Text(goalUser.username)
                      .font(Font.custom("Quicksand-Regular", size: 20))
                      .padding(.leading, 1)
                }
                Spacer()
                Image(systemName: "chevron.backward")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16)
                .foregroundColor(.white)
                .padding(.trailing, 5)
            }.padding(.bottom, 20)
          
            Text(goal.name)
              .font(Font.custom("Quicksand-Bold", size: 28))
              .padding(.leading, 10)
              .padding(.bottom, 1)
          
          Text("Started on \(dateFormatter.string(from: goal.dateStarted))")
            .foregroundColor(Color(UIColor(hex: "#4C4C4C")))
            .font(Font.custom("Quicksand-Regular", size: 20))
            .padding(.leading, 10)
//            .padding(.bottom, 2)
          
            if let desc = goal.description {
              if desc != "" {
                Text(desc)
                  .foregroundColor(Color(UIColor(hex: "#4C4C4C")))
                  .font(Font.custom("Quicksand-Regular", size: 20))
                  .padding(.leading, 10)
//                  .padding(.bottom, 2)
              }
            }
            
          VStack(alignment: .leading) {
            let percentage = CGFloat(goal.progress)/CGFloat(goal.frequency)
            let progressBarMax = UIScreen.main.bounds.width * 0.8
            HStack {
              Text("\(goal.progress)/\(goal.frequency) photos")
                .font(Font.custom("Quicksand-Bold", size: 16))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
              Text(postController.daysUntilDate(goal.dueDate))
                .font(Font.custom("Quicksand-Bold", size: 16))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 20)
            }
            ZStack(alignment: .leading) {
              Capsule()
                .stroke(customYellow, lineWidth: 1)
                .frame(width: progressBarMax)
                .padding(.leading, 22)
              Capsule()
                .frame(width: progressBarMax * percentage)
                .foregroundColor(customYellow)
                .padding(.leading, 22)
            }
            .frame(height: 25, alignment: .center)
            
            VStack(alignment: .leading) {
              Button(action: {
                 isShowingSubgoals.toggle()
              }) {
                if !isShowingSubgoals{
                  HStack {
                    Image(systemName: "arrowtriangle.forward.fill")
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                      .frame(width: 10)
                      .foregroundColor(.gray)
                      .padding(.leading, 20)
                    Text("\(goalController.getCountSubgoals(goal: goal)) subgoals")
                      .font(Font.custom("Quicksand-Regular", size: 14))
                      .foregroundColor(.gray)
                  }.padding(.bottom, 10)
                } else {
                  HStack {
                    Image(systemName: "arrowtriangle.down.fill")
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                      .frame(width: 10)
                      .foregroundColor(.gray)
                      .padding(.leading, 20)
                    Text("\(goalController.getCountSubgoals(goal: goal)) subgoals")
                      .font(Font.custom("Quicksand-Regular", size: 14))
                      .foregroundColor(.gray)
                  }.padding(.bottom, 10)
                }
              }
              if isShowingSubgoals {
                VStack (alignment: .leading) {
                  //Subgoal
                  ForEach(goalController.getSubgoalsForGoal(goal: goal)) { subgoal in
//                    Capsule()
//                      .foregroundColor(Color.green)
//                      .frame(height: 30, alignment: .leading)
//                      .overlay(
//                        HStack{
//                          Image(systemName: "checkmark.circle")
//                            .frame(width: 20, alignment: .leading)
//                            .padding(.leading, 8)
//                          Text(subgoal.name)
//                            .font(.system(size: 10))
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                        }
//                      )
//                      .frame(maxWidth: .infinity, alignment: .leading)
//                      .padding(.horizontal, 25)
                    if subgoal.isCompleted {
                      HStack(spacing: 10) {
                          Image("checkmark")
                              .resizable()
                              .aspectRatio(contentMode: .fit)
                              .frame(width: 15, alignment: .leading)
                              .padding(.leading, 10)

                          Text(subgoal.name)
                              .font(Font.custom("Quicksand-Regular", size: 16))
                              .foregroundColor(.white)
                              .padding(.trailing, 10)
                      }
                      .background(
                          Capsule()
                            .foregroundColor(Color(UIColor(hex: "#53B141")))
                              .frame(height: 28)
                      )
                      .frame(maxWidth: .infinity, alignment: .leading)
                      .padding(.leading, 20)
                      .padding(.bottom, 10)
                    } else {
                      HStack(spacing: 10) {
                        Text(subgoal.name)
                          .font(Font.custom("Quicksand-Regular", size: 16))
                          .foregroundColor(.black)
                          .padding(.trailing, 10)
                          .padding(.leading, 10)
                      }
                      .background(
                        Capsule()
                          .foregroundColor(Color(UIColor(hex: "#E0E0E0")))
                          .frame(height: 28)
                      )
                      .frame(maxWidth: .infinity, alignment: .leading)
                      .padding(.leading, 20)
                      .padding(.bottom, 10)
                    }
                  }
                }
              }
            }.padding(.top, 10)
          }
          .padding(.top, 20)
          .padding(.bottom, 20)
          .background(
            RoundedRectangle(cornerRadius: 12)
              .stroke(Color(UIColor(hex: "#B8B8B8")), lineWidth: 1)
          )

        }
        .padding()
        .padding(.bottom, 25)
        .navigationBarHidden(true)
      
      let pastWeek = postController.getPostsForPastWeek(goalId: goal.id)
      if pastWeek != [] {
        VStack(alignment: .leading) {
          Text("Past Week")
            .font(Font.custom("Quicksand-Bold", size: 20))
            .padding(.leading, 20)
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
              ForEach(pastWeek) { post in
                VStack(spacing: 15) {
                  Image(uiImage: postController.getImageFromURL(url: post.photo))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipped()
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fill)
                }
              }
            }
            .padding(.horizontal, 10)
          }
        }
      }
      Spacer()
      let earlier = postController.getEarlierPosts(goalId: goal.id)
      if earlier != [] {
        VStack(alignment: .leading) {
          Text("Earlier")
            .font(Font.custom("Quicksand-Bold", size: 20))
            .padding(.leading, 20)
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
              ForEach(earlier) { post in
                VStack(spacing: 15) {
                  Image(uiImage: postController.getImageFromURL(url: post.photo))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipped()
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fill)
                }
              }
            }
            .padding(.horizontal, 10)
          }
        }
      }
      Spacer()
    }
}

// DateFormatter for displaying dates
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()
