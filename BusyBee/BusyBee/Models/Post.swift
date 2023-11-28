//
//  Post.swift
//  BusyBee
//
//  Created by elaine wang on 10/24/23.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct Post: Identifiable, Codable, Comparable {
  
  @DocumentID var id: String?
  var goalId: String
  var userId: String
  var caption: String
  var photo: String
  var subgoalId: String? // Optional bc post may or may not pertain to a subgoal
  var timePosted: Date
  var comments: [Comment]
  var reaction1: [String]
  var reaction2: [String]
  var reaction3: [String]
  var reaction4: [String]
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case goalId
    case userId
    case caption
    case photo
    case subgoalId
    case timePosted
    case comments
    case reaction1
    case reaction2
    case reaction3
    case reaction4
  }
  
  // To conform to Comparable protocol
  static func < (lhs: Post, rhs: Post) -> Bool {
    lhs.timePosted < rhs.timePosted
  }
  
  static func == (lhs: Post, rhs: Post) -> Bool {
    lhs.timePosted == rhs.timePosted
  }
  
}
