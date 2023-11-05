// CameraView.swift
// BusyBee
// Created by Ryan McGrady on 11/2/23.

import SwiftUI
import AVFoundation

import SwiftUI
import AVFoundation

struct CameraView: View {
    @StateObject var camera: CameraController
    @EnvironmentObject var viewModeluser: AuthViewModel
    @State private var isPictureTaken = false
    @StateObject var viewModel = CameraViewModel()
  
  
  

    var body: some View {
        ZStack {
            if let capturedImage = camera.capturedImage {
                CreatePostView(uiImage: capturedImage, camera: camera)
            } else {
                CameraPreview(camera: camera)
                    .ignoresSafeArea(.all, edges: .all)
                VStack {
                    HStack {
                        NavigationLink(destination: AppView()) {
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
                        CameraControlsView(camera: camera, isPictureTaken: $isPictureTaken, viewModel: viewModel)
                    }
                    .frame(height: 75)
                }
            }
        }
        .onAppear {
            camera.start()
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


