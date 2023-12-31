//
//  GoalCardView.swift
//  BusyBee
//
//  Created by Joyce Huang on 11/28/23.
//

import SwiftUI

struct GoalCardView: View {
    @EnvironmentObject var goalController: GoalController
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var postController: PostController
 
    var user: User
    var goal: Goal
    var body: some View {
//        NavigationLink(destination: IndividualGoalView(goal: goal)) {
            VStack(alignment: .leading) {
                let goalDueDate = goal.dueDate
                let currentDate = Date()
                let calendar = Calendar.current
                let components = calendar.dateComponents([.day], from: currentDate, to: goalDueDate)
                let dayDifference = components.day
                HStack {
                    HoneyJarView(progress: goal.progress, frequency: goal.frequency)
                        .frame(width: 70, height: 70)
                    VStack(alignment: .leading) {
                        if goal.progress < goal.frequency {
                            Text(goal.name)
                                .font(Font.custom("Quicksand-Bold", size: 16))
                                .foregroundColor(Color.black)
                                .fontWeight(.bold)
                            if let dayDifference = dayDifference {
                                if dayDifference == 1 {
                                    Text("\(dayDifference) Day Left")
                                        .font(Font.custom("Quicksand-Regular", size: 16))
                                        .foregroundColor(.gray)
                                } else if dayDifference >= 0 {
                                    Text("\(dayDifference) Days Left")
                                        .font(Font.custom("Quicksand-Regular", size: 16))
                                        .foregroundColor(.gray)
                                } else if dayDifference == -1 {
                                    Text("\(-1 * dayDifference) Day Overdue")
                                        .font(Font.custom("Quicksand-Regular", size: 16))
                                        .foregroundColor(.gray)
                                } else {
                                    Text("\(-1 * dayDifference) Days Overdue")
                                        .font(Font.custom("Quicksand-Regular", size: 16))
                                        .foregroundColor(.gray)
                                }
                            }
                            Text("\(goalController.getCountSubgoals(goal: goal)) Subgoals")
                                .font(Font.custom("Quicksand-Regular", size: 16))
                                .foregroundColor(Color.gray)
                        } else {
                            HStack {
                                Text(goal.name)
                                    .font(Font.custom("Quicksand-Bold", size: 16))
                                    .foregroundColor(Color.black)
                                    .fontWeight(.bold)
                                Spacer()
                                let dateFormatter: DateFormatter = {
                                    let formatter = DateFormatter()
                                    formatter.dateFormat = "MM/dd/yy"
                                    return formatter
                                }()
                                let startDateString = dateFormatter.string(from: goal.dateStarted)
                                let endDateString = dateFormatter.string(from: goal.dateEnded!)
                                Text("\(startDateString) - \(endDateString)")
                                .font(Font.custom("Quicksand-Regular", size: 14))
                                    .foregroundColor(.gray)
                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(postController.getPostsForGoal(goalId: goal.id)) { post in
                                        VStack(spacing: 15) {
                                            Image(uiImage: postController.getImageFromURL(url: post.photo))
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 60, height: 60)
                                                .cornerRadius(10)
                                                .aspectRatio(contentMode: .fill)
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                Spacer()
                    if goal.progress < goal.frequency{
                        VStack {
                            if let dayDifference = dayDifference {
                                if dayDifference >= 0 {
                                    HStack {
                                        Circle()
                                            .foregroundColor(.green)
                                            .frame(width: 10, height: 10)
                                        Text("On Track")
                                            .font(Font.custom("Quicksand-Bold", size: 16))
                                            .foregroundColor(Color.gray)
                                            
                                    }.padding(.trailing, 14)
                                } else {
                                    HStack {
                                        Circle()
                                            .foregroundColor(.red)
                                            .frame(width: 10, height: 10)
                                        Text("Overdue")
                                            .font(Font.custom("Quicksand-Bold", size: 16))
                                            .foregroundColor(Color.gray)
                                            
                                    }.padding(.trailing, 13)
                                }
                            }
                           Spacer()

                          if user == viewModel.currentUser {
                            HStack{
                              NavigationLink(destination: EditGoalView(goalController: goalController, currentUser: user, goal: goal)) {
                                Image(systemName: "pencil")
                                  .foregroundColor(.gray)
                                  .font(.title)
                              }
                              Button(action: {
                                postController.deleteGoal(goal: goal, currentUser: user)
                              }) {
                                  Image(systemName: "trash")
                                  .foregroundColor(.gray)
                                  .font(.title)
                              }
                            }
                          }
                        }
              
//                    }

                }
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: Color.gray, radius: 4, x: 0, y: 2)
                .padding(EdgeInsets(top: 2, leading: 15, bottom: 0, trailing: 15))
        )
    }
}
