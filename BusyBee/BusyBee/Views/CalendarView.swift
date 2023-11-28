//
//  CalendarView.swift
//  BusyBee
//
//  Created by Ryan McGrady on 11/2/23.
//

import SwiftUI

struct CalendarView: View {
  @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
      Button("Logout") {
        Task {
          viewModel.signOut()
        }
      }
    }
}

//#Preview {
//    CalendarView()
//}
