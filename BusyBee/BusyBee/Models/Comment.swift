//
//  Comment.swift
//  BusyBee
//
//  Created by elaine wang on 11/20/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Comment: Identifiable, Codable, Comparable, Hashable {
  
  var id: String?
  var userId: String
  var body: String
  var timePosted: Date
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case userId
    case body
    case timePosted
  }
  
  // To conform to Comparable protocol
  static func < (lhs: Comment, rhs: Comment) -> Bool {
    lhs.timePosted < rhs.timePosted
  }
  
  static func == (lhs: Comment, rhs: Comment) -> Bool {
    lhs.timePosted == rhs.timePosted
  }
  
}
