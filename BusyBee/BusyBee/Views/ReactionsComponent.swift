//
//  ReactionsComponent.swift
//  BusyBee
//
//  Created by elaine wang on 11/28/23.
//

import SwiftUI

struct ReactionsComponent: View {
    var post: Post
    @EnvironmentObject var postController: PostController
    @EnvironmentObject var viewModel: AuthViewModel
  @Binding var isShowingPopUp: Bool

  
  var body: some View {
    if let user = viewModel.currentUser {
      if let updatedPost = postController.getPostFromId(postId: post.id!) {
        let hexagonSize : CGFloat = 55
        VStack(alignment: .leading) {
          // reaction 1
          if postController.didUserReact1(userId: user.id, post: updatedPost) {
            Button(action: {
              postController.removeReaction(userId: user.id, reactionNum: 1, post: updatedPost)
            }) {
                Image("yheart")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: hexagonSize, height: hexagonSize, alignment: .leading)
            }
            .buttonStyle(BorderlessButtonStyle())
          } else {
            Button(action: {
              postController.reactToPost(userId: user.id, reactionNum: 1, post: updatedPost)
            }) {
                Image("wheart")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: hexagonSize, height: hexagonSize, alignment: .leading)
                  
            }
            .buttonStyle(BorderlessButtonStyle())
          }
          
          // reaction 2
          if postController.didUserReact2(userId: user.id, post: updatedPost) {
            Button(action: {
              postController.removeReaction(userId: user.id, reactionNum: 2, post: updatedPost)
            }) {
                Image("yclapping")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: hexagonSize, height: hexagonSize, alignment: .leading)
            }
            .buttonStyle(BorderlessButtonStyle())
            
          } else {
            Button(action: {
              postController.reactToPost(userId: user.id, reactionNum: 2, post: updatedPost)
            }) {
                Image("wclapping")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: hexagonSize, height: hexagonSize, alignment: .leading)
            }
            .buttonStyle(BorderlessButtonStyle())
            
          }
          
          //reaction 3
          if postController.didUserReact3(userId: user.id, post: updatedPost) {
            Button(action: {
              postController.removeReaction(userId: user.id, reactionNum: 3, post: updatedPost)
            }) {
                Image("ychampagne")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: hexagonSize, height: hexagonSize, alignment: .leading)
            }
            
          } else {
            Button(action: {
              postController.reactToPost(userId: user.id, reactionNum: 3, post: updatedPost)
            }) {
              Image("wchampagne")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: hexagonSize, height: hexagonSize, alignment: .leading)
            }
            .buttonStyle(BorderlessButtonStyle())
            
          }
          
          // reaction 4
          if postController.didUserReact4(userId: user.id, post: updatedPost) {
            Button(action: {
              postController.removeReaction(userId: user.id, reactionNum: 4, post: updatedPost)
            }) {
                Image("ycelebrate")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: hexagonSize, height: hexagonSize, alignment: .leading)
            }
            .padding(1)
            .buttonStyle(BorderlessButtonStyle())
            
          } else {
            Button(action: {
              postController.reactToPost(userId: user.id, reactionNum: 4, post: updatedPost)
            }) {
                Image("wcelebrate")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: hexagonSize, height: hexagonSize, alignment: .leading)
            }
            .padding(1)
            .buttonStyle(BorderlessButtonStyle())
            
          }

        }
        

      }
    }
      
  }
}

//struct ReactionsComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        ReactionsComponent()
//    }
//}
