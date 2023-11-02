//
//  ProfilesView.swift
//  BusyBee
//
//  Created by elaine wang on 11/1/23.
//

import SwiftUI

struct ProfileView: View {
  let customYellow = Color(UIColor(hex: "#FFD111"))
    var body: some View {
        ZStack {
          VStack {

            HStack {
              Button(action: {
                print("Back button tapped")
              }) {
                Image(systemName: "arrow.left")
              }
              .padding().padding().padding()
              
              Spacer()
              
              Button(action: {
                print("Settings button tapped")
              }) {
                Image(systemName: "gear")
              }
              .padding()
            }
            
            
            Image("profilePic")
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 150, height: 150)
              .clipShape(Circle())
              .overlay(Circle().stroke(customYellow, lineWidth: 10))
            
            Text("Your Caption")
              .font(.headline)
              .padding()
            
            Spacer()
            
            HStack {
              Spacer()
              
              Button(action: {
                print("Current Goals button tapped")
              }) {
                Text("Current Goals")
                  .padding()
                  .foregroundColor(.white)
                  .background(Color.yellow)
                  .cornerRadius(8)
              }
              
              Button(action: {
                print("Past Goals button tapped")
              }) {
                Text("Past Goals")
                  .padding()
                  .foregroundColor(.white)
                  .background(Color.yellow)
                  .cornerRadius(8)
              }
              
              Spacer()
            }
            
            Spacer()
          }
        }
        .edgesIgnoringSafeArea(.top)
          // Background Image
          .background(
          GeometryReader { geometry in
            Image("HoneyGraphic")
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: geometry.size.width)
              .frame(maxHeight: UIScreen.main.bounds.height / 3)
              .edgesIgnoringSafeArea(.top)
          })

    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
