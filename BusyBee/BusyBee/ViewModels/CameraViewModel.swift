//
//  CameraViewModel.swift
//  BusyBee
//
//  Created by Ryan McGrady on 11/3/23.
//

import Foundation


class CameraViewModel: ObservableObject {
    @Published var isCreatePostViewPresented = false
    @Published var isShareButtonEnabled = true
}
