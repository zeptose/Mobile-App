//
//  SearchRow.swift
//  BusyBee
//
//  Created by elaine wang on 11/2/23.
//

import SwiftUI

struct SearchRow: View {
    var user: User
    
    var body: some View {
      VStack {
        NavigationLink(
          destination: ProfileView(user: user),
          label: {
            Text(user.username)
              .font(.headline)
            Spacer()
          
        })
      }
    }
}

//struct SearchRow_Previews: PreviewProvider {
//    static var previews: some View {
//      let user = User(username: testing1, goals: [], posts: [], follows: [])
//      SearchRow(user: user)
//    }
