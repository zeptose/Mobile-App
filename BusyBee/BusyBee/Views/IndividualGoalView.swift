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

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                }
                .padding()
                Spacer()
            }

            Text(goal.name)
                .font(.title)
                .bold()
                .padding(.leading, 10)

            Text("Due Date: \(dateFormatter.string(from: goal.dueDate))")
                .foregroundColor(.gray)
                .font(.system(size: 18))
                .padding(.leading, 10)

            Text("Frequency: \(goal.frequency)")
                .foregroundColor(.gray)
                .font(.system(size: 18))
                .padding(.leading, 10)
        }
        .padding()
        .padding(.bottom, 40)
        .navigationBarHidden(true)
      
      if let feedGoal = goalController.getGoalFromId(goalId: goal.id) {
          let percentage = CGFloat(feedGoal.progress)/CGFloat(feedGoal.frequency)
        let progressBarMax = UIScreen.main.bounds.width * 0.9
              RoundedRectangle(cornerRadius: 12)
                .fill(Color(.clear))
                .frame(height: 45)
                .overlay(
                  VStack{
                    HStack{
                      Text("\(feedGoal.progress)/\(feedGoal.frequency)")
                        .font(.system(size: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 25)

                    }
                    ZStack(alignment: .leading) {
                      Capsule().frame(width: progressBarMax)
                        .foregroundColor(Color.gray)
                      Capsule().frame(width: progressBarMax * percentage)
                        .foregroundColor(Color.yellow)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 20)
                    .padding(.horizontal, 25)
                    .padding(.bottom, 40)
                  }
                )
                
        }
      
        VStack (alignment: .leading) {
          //Subgoal
            ForEach(goalController.getSubgoalsForGoal(goal: goal)) { subgoal in
              Capsule()
                .foregroundColor(Color.green)
                .frame(height: 30, alignment: .leading)
                .overlay(
                  HStack{
                    Image(systemName: "checkmark.circle")
                      .frame(width: 20, alignment: .leading)
                      .padding(.leading, 8)
                    Text(subgoal.name)
                      .font(.system(size: 10))
                      .frame(maxWidth: .infinity, alignment: .leading)
                  }
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 25)

            }
        }.padding(.bottom, 30)
          

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(postController.getPostsForGoal(goalId: goal.id)) { post in
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
        Spacer()
    }
}

// DateFormatter for displaying dates
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()
