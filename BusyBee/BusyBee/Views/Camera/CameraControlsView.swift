//
//  CameraControlsView.swift
//  BusyBee
//
//  Created by Ryan McGrady on 11/2/23.
//

import SwiftUI

struct CameraControlsView: View {
    @EnvironmentObject var camera: CameraController
    @Binding var isPictureTaken: Bool
    @ObservedObject var viewModel: CameraViewModel

    var body: some View {
        HStack {
            Button(action: {
                camera.toggleFlash()
            }, label: {
                let symbolName = camera.flashMode == .on ? "bolt.fill" : "bolt"
                Image(systemName: symbolName)
                    .foregroundColor(.white)
                    .padding()
                    .font(.system(size: 36))
            })
            .padding(.leading, 15)

            Spacer()
                .frame(width: 30)

            Button(action: {
                DispatchQueue.main.async {
                    camera.takePhoto()
                    DispatchQueue.main.async {
                        isPictureTaken = true
//                        viewModel.isCreatePostViewPresented = true
                    }
                }
            }, label: {
                Circle()
                    .stroke(Color.white, lineWidth: 4)
                    .frame(width: 70, height: 70)
            })

            Spacer()
                .frame(width: 30)

            Button(action: {
                camera.flipCamera()
            }, label: {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .foregroundColor(.white)
                    .padding()
                    .font(.system(size: 36))
            })
        }
        .padding(.bottom, 50)
    }
}
