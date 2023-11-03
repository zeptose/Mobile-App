// CameraView.swift
// BusyBee
// Created by Ryan McGrady on 11/2/23.

import SwiftUI
import AVFoundation

struct CameraView: View {
    @StateObject var camera: CameraController
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            CameraPreview(camera: camera)
                .ignoresSafeArea(.all, edges: .all)

            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding()
                            .font(.system(size: 30))
                    })
                    .padding(.trailing, 10)
                }
                Spacer()
                HStack { CameraControlsView(camera: camera) }.frame(height: 75)
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


