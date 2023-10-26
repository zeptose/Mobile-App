//
//  Users.swift
//  BusyBee
//
//  Created by elaine wang on 10/24/23.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct User: Identifiable, Codable, Comparable {
  
  @DocumentID var id: String?
  var username: String
  var password: String
  var bio: String?
  var goals: [Goal]
  var posts: [Post]
  var follows: [User]
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case username
    case password
    case bio
    case goals
    case posts
    case follows
  }
  
  // To conform to Comparable protocol
  static func < (lhs: User, rhs: User) -> Bool {
    lhs.username < rhs.username
  }
  
  static func == (lhs: User, rhs: User) -> Bool {
    lhs.username == rhs.username
  }
  
}
