//
//  Subgoal.swift
//  BusyBee
//
//  Created by elaine wang on 10/31/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Subgoal: Identifiable, Codable, Comparable {
  
  @DocumentID var id: String?
  var name: String
  var isCompleted: Bool
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case isCompleted
  }
  
  // To conform to Comparable protocol
  static func < (lhs: Subgoal, rhs: Subgoal) -> Bool {
    lhs.name < rhs.name
  }
  
  static func == (lhs: Subgoal, rhs: Subgoal) -> Bool {
    lhs.name == rhs.name
  }
}
