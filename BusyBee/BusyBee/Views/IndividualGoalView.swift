//
//  IndividualGoalView.swift
//  BusyBee
//
//  Created by Joshua Yu  on 11/6/23.
//

import SwiftUI

struct IndividualGoalView: View {
    var goal: Goal
//    var post: Post
    @EnvironmentObject var postController: PostController
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                }
                .padding()
                Spacer()
            }

            Text("Goal Details")
                .font(.title)
                .padding()

            Text("Name: \(goal.name)")
            Text("Due Date: \(dateFormatter.string(from: goal.dueDate))")
            Text("Frequency: \(goal.frequency)")

            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
      
//        VStack {
//          let postList = postController.getPostsForGoal(goalId: post.goalId)
//          // Photo
//          ForEach(postList) { post in
//            Image(uiImage: postController.getImageFromURL(url: post.photo))
//              .resizable()
//              .scaledToFill()
//              .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 280)
//              .clipped()
//          }
//        }
    }
}



// DateFormatter for displaying dates
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()


