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
    @Published var commentRepository: CommentRepository = CommentRepository()
    @Published var subgoalRepository: SubgoalRepository = SubgoalRepository()
    @Published var images: [(String, UIImage)] = []
    @Published var posts: [Post] = []
    @Published var userController: UserController = UserController()
    @Published var goalController: GoalController = GoalController()
    @Published var comments: [Comment] = []
  
  init() {
    self.postRepository.get({ (posts) -> Void in
      self.posts = posts
    
      for url in posts.map({$0.photo}) {
          let _ = self.postRepository.getPhoto({ (image) -> Void in self.images.append((url, image)) }, url)
        }
      })
    }
  
    
  func addPost(currentUser: User, goal: Goal, caption: String, photo: String, subgoalId: String?) {
      let timePosted = Date()
      let newPost = Post(goalId: goal.id ,
                         userId: currentUser.id,
                         caption: caption,
                         photo: photo,
                         subgoalId: subgoalId,
                         timePosted: timePosted,
                         comments: [],
                         reaction1: [],
                         reaction2: [],
                         reaction3: [],
                         reaction4: [])
      
      postRepository.create(newPost)
      
    if subgoalId != "-1"{
      if let sgId = subgoalId {
        if let subgoalObject = goalController.getSubgoalFromId(subgoalId: sgId) {
          var sgobject = subgoalObject
          sgobject.isCompleted = true
          subgoalRepository.update(sgobject)
        } else {
          print("Error finding subgoal")
        }
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
      let data = photo.jpegData(compressionQuality: 0.1)
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
    let feedPosts = people.map { self.getPosts(currentUser: $0) }
    let flatFeedPosts = feedPosts.flatMap{ $0 }
    return flatFeedPosts.sorted { $0.timePosted >= $1.timePosted }
  }
  
  func getPostsForGoal(goalId: String) -> [Post] {
    let posts = self.posts.filter { String($0.goalId) == String(goalId)  }
    return posts
  }
  
  func getPostFromId(postId: String) -> Post? {
    let temp = self.posts.first( where: {$0.id == postId} )
    if let ourPost = temp {
      return ourPost
    } else {
      return nil
    }
  }
  
  func addComment(commenterId: String, postId: String, body: String) {
    let timePosted = Date()
    let newComment = Comment(userId: commenterId, body: body, timePosted: timePosted)
    commentRepository.create(newComment)
    
    if let currPost = getPostFromId(postId: postId) {
      var temp = currPost
      temp.comments.append(newComment)
      postRepository.update(temp)
    }
    
  }
  
  func reactToPost(userId: String, reactionNum: Int, post: Post) {
      var temp = post
      
      if reactionNum == 1 {
        temp.reaction1.append(userId)
      } else if reactionNum == 2 {
        temp.reaction2.append(userId)
      } else if reactionNum == 3 {
        temp.reaction3.append(userId)
      } else if reactionNum == 4 {
        temp.reaction4.append(userId)
      }
      
      postRepository.update(temp)
  }
  
  func removeReaction(userId: String, reactionNum: Int, post: Post) {
      var temp = post
      
      if reactionNum == 1 {
        let ind = temp.reaction1.firstIndex(of: userId)
        temp.reaction1.remove(at: ind!)
      } else if reactionNum == 2 {
        let ind = temp.reaction2.firstIndex(of: userId)
        temp.reaction2.remove(at: ind!)
      } else if reactionNum == 3 {
        let ind = temp.reaction3.firstIndex(of: userId)
        temp.reaction3.remove(at: ind!)
      } else if reactionNum == 4 {
        let ind = temp.reaction4.firstIndex(of: userId)
        temp.reaction4.remove(at: ind!)
      }
      
      postRepository.update(temp)
  }
  
  func didUserReact1(userId: String, post: Post) -> Bool {
    if post.reaction1.contains(userId) {
      return true
    }
    return false
  }
  
  func didUserReact2(userId: String, post: Post) -> Bool {
    if post.reaction2.contains(userId) {
      return true
    }
    return false
  }
  
  func didUserReact3(userId: String, post: Post) -> Bool {
    if post.reaction3.contains(userId) {
      return true
    }
    return false
  }
  
  func didUserReact4(userId: String, post: Post) -> Bool {
    if post.reaction4.contains(userId) {
      return true
    }
    return false
  }
  
  func commentToTuple(comment: Comment) -> (String, String, Date) {
      return (comment.userId, comment.body, comment.timePosted)
  }
  
  // returns username of poster, comment body, and date posted
  func getPostComments(post: Post) -> [(String, String, Date)] {
    let commentTuples = post.comments.map { commentToTuple(comment: $0) }
    return commentTuples
  }
  
  func timeAgoString(from date: Date) -> String {
      let currentDate = Date()
      let calendar = Calendar.current

      if let seconds = calendar.dateComponents([.second], from: date, to: currentDate).second, seconds < 60 {
          return "\(seconds) seconds ago"
      } else if let minutes = calendar.dateComponents([.minute], from: date, to: currentDate).minute, minutes < 60 {
          return "\(minutes) minutes ago"
      } else if let hours = calendar.dateComponents([.hour], from: date, to: currentDate).hour, hours < 24 {
          return "\(hours) hours ago"
      } else if let days = calendar.dateComponents([.day], from: date, to: currentDate).day, days < 7 {
          return "\(days) days ago"
      } else if let weeks = calendar.dateComponents([.weekOfMonth], from: date, to: currentDate).weekOfMonth, weeks < 5 {
          return "\(weeks) weeks ago"
      } else if let months = calendar.dateComponents([.month], from: date, to: currentDate).month, months < 12 {
        return "\(months) months ago"
      }  else {
          return "Unknown"
      }
  }
  
  func timeAgoStringAbv(from date: Date) -> String {
      let currentDate = Date()
      let calendar = Calendar.current

      if let seconds = calendar.dateComponents([.second], from: date, to: currentDate).second, seconds < 60 {
          return "\(seconds)s ago"
      } else if let minutes = calendar.dateComponents([.minute], from: date, to: currentDate).minute, minutes < 60 {
          return "\(minutes)m ago"
      } else if let hours = calendar.dateComponents([.hour], from: date, to: currentDate).hour, hours < 24 {
          return "\(hours)h ago"
      } else if let days = calendar.dateComponents([.day], from: date, to: currentDate).day, days < 7 {
          return "\(days)d ago"
      } else if let weeks = calendar.dateComponents([.weekOfMonth], from: date, to: currentDate).weekOfMonth, weeks < 5 {
          return "\(weeks)w ago"
      } else if let months = calendar.dateComponents([.month], from: date, to: currentDate).month, months < 12 {
          return "\(months)mo ago"
      } else {
          return "Unknown"
      }
  }
  
  func deletePost(post: Post, currentUser: User) {
      let currGoal = goalController.getGoalFromId(goalId: post.goalId)
      if var tempGoal = currGoal {
        tempGoal.progress = tempGoal.progress - 1
        goalRepository.update(tempGoal)
      }
      
      var currUser = currentUser
      let i = currUser.posts.firstIndex(where: { $0.photo == post.photo })
      if let i = i {
        currUser.posts.remove(at: i)
      }
      userRepository.update(currUser)
      postRepository.delete(post)
    }

  
}






