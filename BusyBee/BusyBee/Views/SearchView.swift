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
    @EnvironmentObject var userController : UserController
    let customYellow = Color(UIColor(hex: "#FFD111"))
    let customLightGray = Color(UIColor(hex: "#D3D3D3"))
    let customDarkGray = Color(UIColor(hex: "#A9A9A9"))
    @Environment(\.presentationMode) var presentationMode


    
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
              HStack {
                  Button(action: {
                      presentationMode.wrappedValue.dismiss()
                  }) {
                      Image(systemName: "arrow.left")
                  }
                  .padding()
                  Spacer()
              }
              Spacer()
              HStack {
                  Image(systemName: "magnifyingglass")
                      .foregroundColor(Color.gray)

                  ZStack(alignment: .leading) {
                      if self.searchField.isEmpty {
                          Text("Search by username")
                              .foregroundColor(Color.gray.opacity(0.7))
                      }

                      TextField("", text: binding)
                          .foregroundColor(Color.black)
                          .padding(.vertical, 5)
                  }
              }
              .padding(.horizontal, 10)
              .background(
                  RoundedRectangle(cornerRadius: 12)
                      .fill(customLightGray)
              )
                List {
                  Section {
                    ForEach(displayedUsers) { user in
                        Button(action: {
                            self.selectedUser = user
                        }) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(hex: 0xF3F4F6))
                                .frame(height: 60)
                                .frame(maxWidth: .infinity)
                                .overlay(
                                    HStack {
                                      Image("profilePic")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 32, height: 32)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(customYellow, lineWidth: 2))
                                        .padding(.leading, 10)
                                      Text(user.username)
                                        .padding(.leading, 6)
                                        .foregroundColor(Color.black)
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
                .navigationBarTitle("")

            }
            .padding(.horizontal, 20)
            .onAppear(perform: loadData)
            .background(
                NavigationLink(
                  destination: ProfileView(user: selectedUser),
//                                    .navigationBarBackButtonHidden(true),
                    isActive: Binding<Bool>(
                        get: { self.selectedUser != nil },
                        set: { _ in self.selectedUser = nil }
                    ),
                    label: { EmptyView() }
                )
                .navigationBarBackButtonHidden(true)
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


