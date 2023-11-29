//
//  HoneyJarController.swift
//  BusyBee
//
//  Created by Joyce Huang on 11/29/23.
//

import UIKit

class HoneyJarViewController: UIViewController, ObservableObject {
    
    func cropImageFromBottom(percentage: CGFloat) -> UIImage? {
        let image = UIImage(named: "EmptyJarPic2")!
        let imageSize = image.size
        let croppedHeight = imageSize.height * percentage
        let startY = imageSize.height - croppedHeight

        UIGraphicsBeginImageContextWithOptions(CGSize(width: imageSize.width, height: imageSize.height - croppedHeight), false, 0.0)
        defer { UIGraphicsEndImageContext() }

        guard let context = UIGraphicsGetCurrentContext() else { return nil }

        let drawRect = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height - croppedHeight)
        context.clip(to: drawRect)
        image.draw(in: CGRect(x: 0, y: -startY, width: imageSize.width, height: imageSize.height))

        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

