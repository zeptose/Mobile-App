//
//  IndividualGoalView.swift
//  BusyBee
//
//  Created by Joshua Yu  on 11/6/23.
//

import SwiftUI

struct IndividualGoalView: View {
    var goal: Goal
<<<<<<< HEAD

    var body: some View {
        VStack {
=======
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

>>>>>>> d20722c3f852ee12015e7e8ef0fec3cd91207ec6
            Text("Goal Details")
                .font(.title)
                .padding()

            Text("Name: \(goal.name)")
            Text("Due Date: \(dateFormatter.string(from: goal.dueDate))")
            Text("Frequency: \(goal.frequency)")
<<<<<<< HEAD
            
        }
    }
}

=======

            Spacer()
        }
        .padding()
        .navigationBarHidden(true) // Optional: Hide navigation bar
    }
}



>>>>>>> d20722c3f852ee12015e7e8ef0fec3cd91207ec6
// DateFormatter for displaying dates
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()
<<<<<<< HEAD

=======
>>>>>>> d20722c3f852ee12015e7e8ef0fec3cd91207ec6
