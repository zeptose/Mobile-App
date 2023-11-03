//
//  CreatePostView.swift
//  BusyBee
//
//  Created by Ryan McGrady on 11/3/23.
//

import SwiftUI

struct CreatePostView: View {
    var uiImage: UIImage // Assuming you're using UIImage for the captured image
    @State private var caption: String = ""
    @StateObject var camera: CameraController
    @Environment(\.presentationMode) var presentationMode

    @State private var uploadedImageURL: String = ""

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                HStack {
                    NavigationLink(destination: CameraView(camera: camera)) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .padding()
                            .font(.system(size: 30))
                    }
                    .padding(.leading, 10)
                    Spacer()
                    Button(action: {
                        // Call the upload function from PostController
                        uploadedImageURL = PostController().uploadPhoto(uiImage)
                    }) {
                        Text("Share")
                    }
                }
                .padding()

                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.65)
                    .clipped()

                TextField("Write a caption...", text: $caption)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Display the uploaded image URL in a TextField
                TextField("Uploaded Image URL", text: $uploadedImageURL)
                    .padding()

            }
            .padding()
            .navigationBarBackButtonHidden(true)
        }
        .onTapGesture {
            camera.capturedImage = nil
        }
    }
}
