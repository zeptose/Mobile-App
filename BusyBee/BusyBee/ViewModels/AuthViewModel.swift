//
//  AuthViewModel.swift
//  BusyBee
//
//  Created by elaine wang on 11/1/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol AuthenticationFormProtocol {
  var formIsValid: Bool { get }
}

class AuthViewModel: ObservableObject {
  @Published var userSession: FirebaseAuth.User?
  @Published var currentUser: User?
  @Published var userRepository: UserRepository = UserRepository()
  
  init() {
    self.userSession = Auth.auth().currentUser
    Task {
      await fetchUser()
    }
  }
  
  func signIn(withEmail email: String, password: String) async throws {
    do {
      let result = try await Auth.auth().signIn(withEmail: email, password: password)
      self.userSession = result.user
      await fetchUser()
    } catch {
      print("Unable to sign in: \(error.localizedDescription)")
    }
  }
  
  func createUser (withEmail email: String, password: String, username: String) async throws {
    do {
      let result = try await Auth.auth().createUser(withEmail: email, password: password)
      self.userSession = result.user
//      let posts: [Post] = []
      let follows: [String] = []
      let followers: [String] = []
//      let goals: [Goal] = []
      let bio = ""
      
      let newUser = User(id: result.user.uid,
                         username: username,
                         bio: bio,
//                         goals: goals,
//                         posts: posts,
                         follows: follows,
                         followers: followers)
      let encodedUser = try Firestore.Encoder().encode(newUser)
      try await Firestore.firestore().collection("users").document(newUser.id).setData(encodedUser)
      await fetchUser()
    } catch {
      print("Unable to create user: \(error.localizedDescription)")
    }
  }
  
  func signOut() {
    do {
      try Auth.auth().signOut()
      self.userSession = nil
      self.currentUser = nil
    } catch {
      print("Unable to sign out: \(error.localizedDescription)")
    }
  }
  
  func deleteAccount() {
    
  }
  
  func fetchUser() async {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
    self.currentUser = try? snapshot.data(as: User.self)
//    print("Current user: \(self.currentUser)")
//    print("uid: \(uid)")
  }
}
