//
//  GoalCardView.swift
//  BusyBee
//
//  Created by Joyce Huang on 11/28/23.
//

import SwiftUI

struct GoalCardView: View {
    @EnvironmentObject var goalController: GoalController
    var user: User
    var goal: Goal
    var body: some View {
        NavigationLink(destination: IndividualGoalView(goal: goal)) {
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
                        Text(goal.name)
                            .font(.headline)
                            .foregroundColor(Color.black)
                            .fontWeight(.bold)
                        if let dayDifference = dayDifference {
                            if dayDifference == 1 {
                                Text("\(dayDifference) Day Left")
                                    .font(.subheadline)
                                    .foregroundColor(Color.black)
                            } else if dayDifference >= 0 {
                                Text("\(dayDifference) Days Left")
                                    .font(.subheadline)
                                    .foregroundColor(Color.black)
                            } else {
                                
                                Text("\(-1 * dayDifference) Days Overdue")
                                    .font(.subheadline)
                                    .foregroundColor(Color.black)
                            }
                        }
                        Text("Subgoals: \(goalController.getCountSubgoals(goal: goal))")
                            .font(.subheadline)
                            .foregroundColor(Color.gray)
                        
                    }
                Spacer()
                    
                VStack {
                    if let dayDifference = dayDifference {
                        if dayDifference >= 0 {
                            HStack {
                                Circle()
                                    .foregroundColor(.green)
                                    .frame(width: 10, height: 10)
                                Text("On Track")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .padding(.trailing, 3)
                            }
                        } else {
                            HStack {
                                Circle()
                                   .foregroundColor(.red)
                                   .frame(width: 10, height: 10)
                                Text("Overdue")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .padding(.trailing, 3)
                            }
                        }
                    }
                    Spacer()
                    NavigationLink(destination: EditGoalView(goalController: goalController, currentUser: user, goal: goal)) {
                        Image(systemName: "pencil")
                            .foregroundColor(.gray)
                            .font(.title)
                        }
                }
                }
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: Color.gray, radius: 4, x: 0, y: 2)
                .padding(EdgeInsets(top: 2, leading: 10, bottom: 0, trailing: 10))
        )
    }
}
