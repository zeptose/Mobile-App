//
//  SearchView.swift
//  BusyBee
//
//  Created by elaine wang on 11/2/23.
//

import SwiftUI

extension Color {
    init(hex: UInt) {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0x00FF00) >> 8) / 255.0
        let blue = Double(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}
struct SearchView: View {
    @ObservedObject var searchViewModel = SearchViewModel()
    @State var searchField: String = ""
    @State var displayedUsers = [User]()
    @ObservedObject var userController = UserController()
    
    @State private var selectedUser: User? // Store the selected user for custom action
    
    var body: some View {
        let binding = Binding<String>(get: {
            self.searchField
        }, set: {
            self.searchField = $0
            self.searchViewModel.search(searchText: self.searchField)
            self.displayUsers()
        })
        
        NavigationView {
            VStack {
                Spacer()
                TextField(" Search by username", text: binding)
                  .padding(.leading, 15)
                List {
                  Section {
                    ForEach(displayedUsers) { user in
                        Button(action: {
                            self.selectedUser = user
                        }) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(hex: 0xF3F4F6))
                                .frame(height: 60)
                                .overlay(
                                    HStack {
                                        Text(user.username)
                                          .padding(.leading, 10)
//                                            .font(.custom("Lato-Regular", size: 16))
                                        Spacer()
                                    }
                                )
                        }
                    }.listRowSeparator(.hidden)
                  } header: {
                    Text("Users")
                  }
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle("Search for friends")
            }
            .onAppear(perform: loadData)
            .background(
                NavigationLink(
                    destination: ProfileView(user: selectedUser),
                    isActive: Binding<Bool>(
                        get: { self.selectedUser != nil },
                        set: { _ in self.selectedUser = nil }
                    ),
                    label: { EmptyView() }
                )
            )
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
