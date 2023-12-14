//
//  ReloadViewModel.swift
//  BusyBee
//
//  Created by Ryan McGrady on 12/14/23.
//

import FirebaseFirestore
import Combine

class PostViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private var firestore = Firestore.firestore()

    @Published var posts: [Post] = []

    func fetchPostsFromFirestore() {
        firestore.collection("posts")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                self.posts = documents.compactMap { queryDocumentSnapshot -> Post? in
                    return try? queryDocumentSnapshot.data(as: Post.self)
                }
            }
    }
}
