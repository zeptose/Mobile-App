//
//  CameraController.swift
//  BusyBee
//
//  Created by Ryan McGrady on 11/2/23.
//

import AVFoundation
import SwiftUI

class CameraController: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
  @Published var session = AVCaptureSession()
  @Published var output = AVCapturePhotoOutput()
  @Published var flashMode: AVCaptureDevice.FlashMode = .off
  @Published var capturedImage: UIImage?
  @Published var alert = false
  @Published var photos = []
  @Published var images : [UIImage] = []
  
  var backCamera : AVCaptureDevice!
  var frontCamera : AVCaptureDevice!
  
  var backInput : AVCaptureInput!
  var frontInput : AVCaptureInput!
  
  var backCameraOn = true
  var cameraView: UIView?
  
  override init() {
    super.init()
    checkPermissions()
    setUp()
    cameraView = createCameraView()
  }
  
  private func createCameraView() -> UIView {
      let view = UIView(frame: UIScreen.main.bounds)

      let previewLayer = AVCaptureVideoPreviewLayer(session: session)
      previewLayer.frame = view.bounds
      previewLayer.videoGravity = .resizeAspectFill
      view.layer.addSublayer(previewLayer)

      return view
  }

  
  private func checkPermissions() {
      switch AVCaptureDevice.authorizationStatus(for: .video) {
      case .authorized:
          return
      case .notDetermined:
          AVCaptureDevice.requestAccess(for: .video) { (status) in
              if status {
                  DispatchQueue.main.async {
                      self.cameraView = self.createCameraView()
                  }
              }
          }
      case .denied:
          self.alert.toggle()
          return
      default:
          return
      }
  }

  
  func setUp() {
    DispatchQueue.global(qos: .userInitiated).async{
      self.session.beginConfiguration()
      
      self.session.automaticallyConfiguresCaptureDeviceForWideColor = true
      
      self.setUpInputs()
      
      self.setUpOutput()
      
      self.session.commitConfiguration()
    }
  }

  func setUpInputs() {
      if let device = AVCaptureDevice.default(.builtInTripleCamera, for: .video, position: .back) {
        backCamera = device
        do {
          try backCamera.lockForConfiguration()
          let zoomFactor:CGFloat = 8
          backCamera.videoZoomFactor = zoomFactor
          backCamera.unlockForConfiguration()
        } catch {
          print("ZOOM ERROR")
        }
      } else {
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
          backCamera = device
        } else {
          fatalError("no back camera")
        }
      }
      
      if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
        frontCamera = device
      } else {
        fatalError("no front camera")
      }
      
      guard let bInput = try? AVCaptureDeviceInput(device: backCamera) else {
        fatalError("could not create input device from back camera")
      }
      backInput = bInput
      if !session.canAddInput(backInput) {
        fatalError("could not add back camera input to capture session")
      }
      
      guard let fInput = try? AVCaptureDeviceInput(device: frontCamera) else {
        fatalError("could not create input device from front camera")
      }
      frontInput = fInput
      if !session.canAddInput(frontInput) {
        fatalError("could not add front camera input to capture session")
      }
      
      //connect back camera input to session
      session.addInput(backInput)
    }
    
    func setUpOutput() {
      if self.session.canAddOutput(self.output) {
        self.session.addOutput(self.output)
        
      }
    }
  
  func start () {
    DispatchQueue.global(qos: .userInitiated).async {
      self.session.startRunning()
    }
  }
  
  func stop() {
      DispatchQueue.global(qos: .userInitiated).async {
          self.session.stopRunning()
      }
  }
  
  func toggleFlash() {
    if self.flashMode == .off {
      self.flashMode = .on
    } else {
      self.flashMode = .off
    }
  }
  
  
  
  func flipCamera() {
    session.beginConfiguration()
    if backCameraOn {
      if let frontInput = frontInput {
        session.removeInput(backInput!)
        session.addInput(frontInput)
        backCameraOn = false
      }
    } else {
      if let backInput = backInput {
        session.removeInput(frontInput!)
        session.addInput(backInput)
        backCameraOn = true
      }
    }
    session.commitConfiguration()
  }
  
  
  func getSettings() -> AVCapturePhotoSettings {
    let settings = AVCapturePhotoSettings()
    
    if backCameraOn && backCamera.hasFlash {
      settings.flashMode = flashMode
    } else if frontCamera.hasFlash {
      settings.flashMode = flashMode
    }
    return settings
  }
  
  func takePhoto() {
    DispatchQueue.global(qos: .background).async {
      self.output.capturePhoto(with: self.getSettings(), delegate: self)
    }
  }
  
  func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
      if let error = error {
          fatalError(error.localizedDescription)
      }

      if let imageData = photo.fileDataRepresentation(), let image = UIImage(data: imageData) {
          capturedImage = image

          DispatchQueue.main.async {
              self.photos.append(imageData)
              self.images.append(image)
          }

          UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
      }
  }
}

