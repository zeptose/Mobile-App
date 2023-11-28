//
//  CommentRepository.swift
//  BusyBee
//
//  Created by elaine wang on 11/20/23.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class CommentRepository: ObservableObject {
  // Set up properties here
  private let store = Firestore.firestore()
  let path = "comments"
  
  @Published var comments: [Comment] = []
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    self.get({ (comments) -> Void in
          self.comments = comments
        })
  }

  func get(_ completionHandler: @escaping (_ comments: [Comment]) -> Void) {
      store.collection(path)
        .addSnapshotListener { querySnapshot, error in
          if let error = error {
            print("Error getting comments: \(error.localizedDescription)")
            return
          }
          
          let comments = querySnapshot?.documents.compactMap { document in
            try? document.data(as: Comment.self)
          } ?? []
          completionHandler(comments)
        }
    }
  
  func create(_ comment: Comment) {
    do {
        let newComment = comment
        _ = try store.collection(path).addDocument(from: newComment)
      } catch {
        fatalError("Unable to add comment: \(error.localizedDescription).")
      }
  }
  
  func update(_ comment: Comment) {
    guard let commentId = comment.id else { return }
    
    do {
      try store.collection(path).document(commentId).setData(from: comment)
    } catch {
      fatalError("Unable to update comment: \(error.localizedDescription).")
    }
  }

  func delete(_ comment: Comment) {
    guard let commentId = comment.id else { return }
    
    store.collection(path).document(commentId).delete { error in
      if let error = error {
        print("Unable to remove comment: \(error.localizedDescription)")
      }
    }
  }
}
