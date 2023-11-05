//
//  PostController.swift
//  BusyBee
//
//  Created by Ryan McGrady on 11/3/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

class PostController: ObservableObject {
    @Published var postRepository: PostRepository = PostRepository()
    @Published var userRepository: UserRepository = UserRepository()
  
  @Published var posts: [Post] = []
  
  init() {
    self.postRepository.get({ (posts) -> Void in
      self.posts = posts
      
    })
  }
  
    
    func addPost(currentUser: User, goal: Goal, caption: String, photo: String, subgoal: String?, comments: [String], reactions: Int) {
        let timePosted = Date()
        
        let newPost = Post(goalId: goal.id ?? "",
                           userId: currentUser.id,
                           caption: caption,
                           photo: photo,
                           subgoal: subgoal,
                           timePosted: timePosted,
                           comments: comments,
                           reactions: reactions)
        
        postRepository.create(newPost)
        
        var user = currentUser
        user.posts.append(newPost)
        userRepository.update(user)
        
        var goal = 
    }
    
    func getPosts(currentUser: User) -> [Post] {
        let currPosts = self.posts.filter{ String($0.userId) == String(currentUser.id) }
        return currPosts.sorted { $0.timePosted > $1.timePosted }
    }
  
  func uploadPhoto(_ photo: UIImage) -> String {
      print(photo)
      let url = "\(UUID().uuidString).jpg"
      let storageRef = Storage.storage().reference().child(url)
      let data = photo.jpegData(compressionQuality: 0.2)
      let metadata = StorageMetadata()
      metadata.contentType = "image/jpg"
      if let data = data {
        storageRef.putData(data, metadata: metadata) { (metadata, error) in
          if let error = error {
            print("Error while uploading file: ", error)
          }
          if let metadata = metadata {
            print("Metadata: ", metadata)
          }
        }
      }
    
      return url
    }
}



