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
        .navigationBarHidden(true)

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
