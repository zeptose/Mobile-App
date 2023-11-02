//
//  CameraView.swift
//  BusyBee
//
//  Created by Ryan McGrady on 11/2/23.
//

import SwiftUI
import AVFoundation
import UIKit

struct CameraView: View {
    @StateObject var camera: CameraController
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            CameraPreview(camera: camera)
                .ignoresSafeArea(.all, edges: .all)

            if camera.isTaken {
                GeometryReader { geo in
                    Image(uiImage: camera.images[1])
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width + 20, height: geo.size.width / 3 * 4)
                        .ignoresSafeArea(.all, edges: .all)
                }
            }

            if camera.image1Done {
                VStack {
                    HStack {
                        Button(action: {
                            let temp = camera.images[0]
                            camera.images[0] = camera.images[1]
                            camera.images[1] = temp
                        }) {
                            Image(uiImage: camera.images[0])
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 200)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.white, lineWidth: 1.5)
                                )
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .padding(20)
            }

            VStack {
                // after photo is taken -> add controls
                HStack {
                    Spacer()
                    Button(action: {
                        if camera.isTaken {
                            camera.reTake()
                        } else {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding()
                            .font(.system(size: 30))
                    })
                    .padding(.trailing, 10)
                }
                Spacer()
                HStack {
                    if camera.isTaken {
                        // Add controls specific to when an image is taken
                        Text("Add Controls Here")
                    } else if camera.showControls {
                        CameraControlsView(camera: camera)
                    }
                }
                .frame(height: 75)
            }
        }
    }
}

struct CameraPreview: UIViewRepresentable {
    var camera: CameraController

    func updateUIView(_ uiView: UIView, context: Context) {}

    func makeUIView(context: Context) ->  UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        view.layer.addSublayer(setupCapturePreview())
        return view
    }

    private func setupCapturePreview() -> AVCaptureVideoPreviewLayer {
        let preview = AVCaptureVideoPreviewLayer(session: camera.session)
        preview.frame = camera.view.frame
        preview.videoGravity = .resizeAspectFill
        return preview
    }
}
