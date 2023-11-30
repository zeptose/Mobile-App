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
    var progress: Int
    var frequency: Int
    
    var body: some View {
        let percentage =  CGFloat(progress/frequency)
        ZStack {
            Image("FilledHoneyJar")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 90, height: 80)
            if let overlayImage = jarController.cropImageFromTop(percentage: 1 - percentage) {
                Image(uiImage: overlayImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80, alignment: .top)
            }
            Image("JarBeePic")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 55, height: 55, alignment: .bottom)
                .padding(EdgeInsets(top: 40, leading: -10, bottom: 0, trailing: 10))
            Text("\(progress)/\(frequency)")
                .font(.caption2)
                .foregroundColor(Color.black)
                .padding(EdgeInsets(top: 50, leading: -8, bottom: 0, trailing: 20))
            
            
        }
    }
}
