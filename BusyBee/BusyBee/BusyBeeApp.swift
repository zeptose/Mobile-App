//
//  BusyBeeApp.swift
//  BusyBee
//
//  Created by elaine wang on 10/24/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


@main
struct BusyBeeApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @StateObject var viewModel = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(viewModel)
        }
    }
}


