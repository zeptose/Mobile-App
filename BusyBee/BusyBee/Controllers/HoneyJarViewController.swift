//
//  HoneyJarController.swift
//  BusyBee
//
//  Created by Joyce Huang on 11/29/23.
//

import UIKit

class HoneyJarViewController: UIViewController, ObservableObject {
    
    func cropImageFromTop(percentage: CGFloat) -> UIImage? {
            let originalImage = UIImage(named: "EmptyJarPic")
            let heightToKeep = originalImage!.size.height * percentage
            let rect = CGRect(x: 0, y: 0, width: originalImage!.size.width, height: heightToKeep)

            if let imageRef = originalImage!.cgImage?.cropping(to: rect) {
                let croppedImage = UIImage(cgImage: imageRef)
                return croppedImage
            }

        if heightToKeep == 0 {
            return nil
        } else {
            return originalImage
        }
    }
    
    
}
    

