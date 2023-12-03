// CameraView.swift
// BusyBee
// Created by Ryan McGrady on 11/2/23.

import SwiftUI
import AVFoundation

import SwiftUI
import AVFoundation

struct CameraView: View {
    @EnvironmentObject var camera: CameraController
    @EnvironmentObject var viewModeluser: AuthViewModel
    @State private var isPictureTaken = false
    @StateObject var viewModel = CameraViewModel()
    @EnvironmentObject var postController: PostController
    @Environment(\.presentationMode) var presentationMode

  
  
    var body: some View {
        ZStack {
          if let capturedImage = camera.capturedImage {
            CreatePostView(uiImage: capturedImage)
                  .environmentObject(postController)
                  .navigationBarBackButtonHidden(true)
                  .onAppear {
                      presentationMode.wrappedValue.dismiss()
                  }
          } else {
                CameraPreview(camera: camera)
                    .ignoresSafeArea(.all, edges: .all)
                VStack {
                    HStack {
                      NavigationLink(destination: AppView(selectedTab : 3)) {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .padding()
                                .font(.system(size: 30))
                        }
                        .padding(.leading, 10).navigationBarBackButtonHidden(true)
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        CameraControlsView(isPictureTaken: $isPictureTaken, viewModel: viewModel)
                    }
                    .frame(height: 75)
                }.navigationBarBackButtonHidden(true)
            }
        }
        .onAppear {
            camera.start()
            camera.capturedImage = nil
        }

    }
}



struct CameraPreview: UIViewRepresentable {
    var camera: CameraController

    func updateUIView(_ uiView: UIView, context: Context) {}

    func makeUIView(context: Context) ->  UIView {
        let view = UIView(frame: UIScreen.main.bounds)

        let previewLayer = setupCapturePreview()
        view.layer.addSublayer(previewLayer)

        return view
    }

  private func setupCapturePreview() -> AVCaptureVideoPreviewLayer {
      let preview = AVCaptureVideoPreviewLayer(session: camera.session)
      preview.frame = UIScreen.main.bounds
      preview.videoGravity = .resizeAspectFill

      return preview
  }

}
