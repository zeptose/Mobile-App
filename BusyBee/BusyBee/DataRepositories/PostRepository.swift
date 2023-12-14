//
//  PostRepository.swift
//  BusyBee
//
//  Created by Ryan McGrady on 11/3/23.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

class PostRepository: ObservableObject {
  // Set up properties here
  private let store = Firestore.firestore()
  let path = "posts"
  
  @Published var posts: [Post] = []
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    self.get({ (posts) -> Void in
          self.posts = posts
        })
  }

  func getPhoto(_ completionHandler: @escaping (_ image: UIImage) -> Void, _ url: String) -> Void {
      print("Fetching photo for URL: \(url)")
      self.refreshFirestoreData()
      let storage = Storage.storage()
      let ref = storage.reference().child(url)
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
          ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
              if let error = error {
                  print("Error getting photo \(url): \(error)")
                  return
              }

              guard let imageData = data,
                    let image = UIImage(data: imageData),
                    let compressedImageData = image.jpegData(compressionQuality: 0.01),
                    let compressedImage = UIImage(data: compressedImageData) else {
                  print("Error compressing or converting image")
                  return
              }

              completionHandler(compressedImage)
          }
      }
  }
  
  func refreshFirestoreData() {
          store.collection(path).getDocuments { [weak self] snapshot, error in
              guard let self = self, error == nil else {
                  print("Error refreshing Firestore data: \(error?.localizedDescription ?? "Unknown error")")
                  return
              }

              let refreshedPosts = snapshot?.documents.compactMap { document in
                  try? document.data(as: Post.self)
              } ?? []

              // Update the posts array with refreshed data
              DispatchQueue.main.async {
                  self.posts = refreshedPosts
              }
          }
      }


  
  
  func get(_ completionHandler: @escaping (_ posts: [Post]) -> Void) {
      store.collection(path)
        .addSnapshotListener { querySnapshot, error in
          if let error = error {
            print("Error getting posts: \(error.localizedDescription)")
            return
          }
          
          let posts = querySnapshot?.documents.compactMap { document in
            try? document.data(as: Post.self)
          } ?? []
          completionHandler(posts)
        }
    }
  
  func create(_ post: Post, completion: @escaping () -> Void) {
      do {
          let newpost = post
          _ = try store.collection(path).addDocument(from: newpost)
          completion()
      } catch {
          fatalError("Unable to add post: \(error.localizedDescription).")
      }
  }
  
  func update(_ post: Post) {
    guard let postId = post.id else { return }
    
    do {
      try store.collection(path).document(postId).setData(from: post)
    } catch {
      fatalError("Unable to update subgoal: \(error.localizedDescription).")
    }
  }

  func delete(_ post: Post) {
    guard let subgoalId = post.id else { return }
    
    store.collection(path).document(subgoalId).delete { error in
      if let error = error {
        print("Unable to remove subgoal: \(error.localizedDescription)")
      }
    }
  }
}

