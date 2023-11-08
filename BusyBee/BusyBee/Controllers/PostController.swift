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
    @Published var goalRepository: GoalRepository = GoalRepository()
    @Published var userRepository: UserRepository = UserRepository()
    @Published var subgoalRepository: SubgoalRepository = SubgoalRepository()
    @Published var images: [(String, UIImage)] = []
    @Published var posts: [Post] = []
    @Published var userController: UserController = UserController()
    @Published var goalController: GoalController = GoalController()
  
  init() {
    self.postRepository.get({ (posts) -> Void in
      self.posts = posts
    
      for url in posts.map({$0.photo}) {
          let _ = self.postRepository.getPhoto({ (image) -> Void in self.images.append((url, image)) }, url)
        }
      })
    }
  
    
    func addPost(currentUser: User, goal: Goal, caption: String, photo: String, subgoalId: String?, comments: [String], reactions: Int) {
        let timePosted = Date()
        let newPost = Post(goalId: goal.id ?? "",
                           userId: currentUser.id,
                           caption: caption,
                           photo: photo,
                           subgoalId: subgoalId,
                           timePosted: timePosted,
                           comments: comments,
                           reactions: reactions)
        
        postRepository.create(newPost)
        
      if let sgId = subgoalId {
        if let subgoalObject = goalController.getSubgoalFromId(subgoalId: sgId) {
            var sgobject = subgoalObject
            sgobject.isCompleted = true
            subgoalRepository.update(sgobject)
            } else {
                print("Error finding subgoal")
            }
        }
      
      var currGoal = goal
      let currProgress = currGoal.progress + 1
      currGoal.progress = currProgress
      
      
      var user = currentUser
      user.posts.append(newPost)
      
      userRepository.update(user)
      goalRepository.update(currGoal)
      
    
        
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
  
  func getImageFromURL(url: String) -> UIImage {
    if let (_, image): (String, UIImage) = (self.images.first { $0.0 == url }) {
      return image
    }
    return UIImage()
  }

  func getFeedPosts(currUser: User) -> [Post] {
    let people: [User] = userController.getUserFriends(currentUser: currUser) + [currUser]
//    print("follows: \(people)")
    let feedPosts = people.map { self.getPosts(currentUser: $0) }
//    print("feed posts: \(feedPosts)")
    let flatFeedPosts = feedPosts.flatMap{ $0 }
    return flatFeedPosts.sorted { $0.timePosted >= $1.timePosted }
  }
  
  func getPostsForGoal(goalId: String) -> [Post] {
    let posts = self.posts.filter { String($0.goalId) == String(goalId)  }
    return posts
  }
  
  
}





