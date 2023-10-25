//
//  Post.swift
//  BusyBee
//
//  Created by elaine wang on 10/24/23.
//

import Foundation
import SwiftUI

struct Post: Identifiable, Codable, Comparable {
  
  var id: UUID
  var goal: Goal
  var caption: String
  var photo: String
  var subgoal: String? // Optional bc post may or may not pertain to a subgoal
  var timePosted: Date
  var comments: [String]
  var reactions: Int
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case goal
    case caption
    case photo
    case subgoal
    case timePosted
    case comments
    case reactions
  }
  
  // To conform to Comparable protocol
  static func < (lhs: Post, rhs: Post) -> Bool {
    lhs.timePosted < rhs.timePosted
  }
  
  static func == (lhs: Post, rhs: Post) -> Bool {
    lhs.timePosted == rhs.timePosted
  }
  
}
