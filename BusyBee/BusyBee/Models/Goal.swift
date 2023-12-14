//
//  Goal.swift
//  BusyBee
//
//  Created by elaine wang on 10/24/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Goal: Identifiable, Codable, Comparable, Hashable {
  
  var id: String
  var name: String
  var description: String?
  var dueDate: Date
  var frequency: Int
  var userId: String
  var progress: Int
  var dateStarted: Date
  var dateEnded: Date?
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case description
    case dueDate
    case frequency
    case userId
    case progress
    case dateStarted
    case dateEnded
  }
  
  // To conform to Comparable protocol
  static func < (lhs: Goal, rhs: Goal) -> Bool {
    lhs.name < rhs.name
  }
  
  static func == (lhs: Goal, rhs: Goal) -> Bool {
    lhs.name == rhs.name
  }
}
