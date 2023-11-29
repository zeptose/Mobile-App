//
//  HoneyJarView.swift
//  BusyBee
//
//  Created by Joyce Huang on 11/28/23.
//
import SwiftUI
import UIKit

struct HoneyJarView: View {
    var jarController = HoneyJarViewController()
    var percentage: CGFloat
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("FilledHoneyJar")
                .resizable()
                .aspectRatio(contentMode: .fit)
//            if let overlayImage = jarController.cropImageFromBottom(percentage: percentage) {
//                    Image(uiImage: overlayImage)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(alignment: .bottom)
//             s   }
            
           }
               
           
    }
}
