//
//  CommentSheetView.swift
//  BusyBee
//
//  Created by elaine wang on 11/29/23.
//

import SwiftUI



struct CommentSheetView: View {
    @EnvironmentObject var userController: UserController
    @EnvironmentObject var postController: PostController
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var newComment: String = ""
    @Environment(\.presentationMode) var presentationMode
    var post: Post
  let customYellow = Color(UIColor(hex: "#FFD111"))
  
  var body: some View {
    if let updatedPost = postController.getPostFromId(postId: post.id!) {
      let commentTuples = postController.getPostComments(post: updatedPost)
      let allComments: [CommentTuple] = commentTuples.map { CommentTuple(id: $0.0, body: $0.1, timePosted: $0.2) }
      VStack{
        HStack{
          VStack (alignment: .center){
            Text("Comments")
              .font(.system(size: 20))
              .padding()
          }
          
          VStack (alignment: .trailing){
            Button(action: {
              presentationMode.wrappedValue.dismiss()
            }) {
              Text("X")
                .foregroundColor(.gray)
            }
          }
        }
        Divider()
        List {
          ForEach(allComments,  id: \.self) { comment in
            HStack {
              if let commenter = userController.getUserFromId(userId: comment.id) {
                Image("profilePic")
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 40, height: 40)
                  .clipShape(Circle())
                  .overlay(Circle().stroke(customYellow, lineWidth: 3))
                VStack(alignment: .leading) {
                  Text(commenter.username)
                    .font(.system(size: 15))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                  Text(comment.body)
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                    .frame(maxWidth: 400, alignment: .leading)
                }
              }
            }.padding(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1))
          }
        }.listStyle(PlainListStyle())
        
        //}.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        
        Spacer()
        
        if let user = viewModel.currentUser {
          HStack {
            TextField("Add a comment...", text: $newComment)
              .padding(10)
              .background(
                RoundedRectangle(cornerRadius: 15)
                
                  .strokeBorder(Color(UIColor(hex: "#9DB2CE")), lineWidth: 2)
              )
            
            Button(action: {
              postController.addComment(commenterId: user.id, postId: updatedPost.id!, body: newComment)
            })
            {
              Text("Send")
                .foregroundColor(.blue)
            }
          }
        }
        
      }
    }
  }
}

struct CommentTuple: Identifiable, Hashable {
    var id: String
    var body: String
    var timePosted: Date
}
