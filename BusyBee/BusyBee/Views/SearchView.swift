//
//  SearchView.swift
//  BusyBee
//
//  Created by elaine wang on 11/2/23.
//

import SwiftUI

struct SearchView: View {
  @ObservedObject var searchViewModel = SearchViewModel()
  @State var searchField: String = ""
  @State var displayedUsers = [User]()
  @ObservedObject var userController = UserController()
  
    var body: some View {
        let binding = Binding<String>(get: {
           self.searchField
         }, set: {
           self.searchField = $0
           self.searchViewModel.search(searchText: self.searchField)
           self.displayUsers()
         })
        NavigationView{
          VStack {
            TextField("Value", text: binding)
            List {
              ForEach(displayedUsers) { user in
                SearchRow(user: user)
              }
            }.navigationBarTitle("Search for friends")
          }.onAppear(perform: loadData)
        }
    }
  
  func loadData() {
    let loadedUsers = userController.users
    self.searchViewModel.users = loadedUsers
    self.displayedUsers = loadedUsers
  }
  
  func displayUsers() {
    if searchField == "" {
      displayedUsers = searchViewModel.users
    } else {
      displayedUsers = searchViewModel.filteredUsers
    }
  }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
