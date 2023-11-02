//
//  SearchViewModel.swift
//  BusyBee
//
//  Created by elaine wang on 11/2/23.
//

import Foundation

class SearchViewModel: ObservableObject {
  
  // MARK: Fields
  @Published var users: [User] = []
  @Published var searchText: String = ""
  @Published var filteredUsers: [User] = []
  
  // MARK: Methods
  
  func search(searchText: String) {
      self.filteredUsers = self.users.filter { user in
        return user.username.lowercased().contains(searchText.lowercased())
      }
    }
}
