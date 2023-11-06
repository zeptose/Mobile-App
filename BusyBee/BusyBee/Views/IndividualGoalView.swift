//
//  IndividualGoalView.swift
//  BusyBee
//
//  Created by Joshua Yu  on 11/6/23.
//

import SwiftUI

struct IndividualGoalView: View {
    var goal: Goal

    var body: some View {
        VStack {
            Text("Goal Details")
                .font(.title)
                .padding()

            Text("Name: \(goal.name)")
            Text("Due Date: \(dateFormatter.string(from: goal.dueDate))")
            Text("Frequency: \(goal.frequency)")
            
        }
    }
}

// DateFormatter for displaying dates
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()
