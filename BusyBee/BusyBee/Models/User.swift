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
  
  var id: String
  var username: String
  var bio: String?
//  var goals: [Goal]
//  var posts: [Post]
  var follows: [String]
  var followers: [String]
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case username
    case bio
//    case goals
//    case posts
    case follows
    case followers
  }
  
  // To conform to Comparable protocol
  static func < (lhs: User, rhs: User) -> Bool {
    lhs.username < rhs.username
  }
  
  static func == (lhs: User, rhs: User) -> Bool {
    lhs.username == rhs.username
  }
  
}
