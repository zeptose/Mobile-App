//
//  ContentView.swift
//  BusyBee
//
//  Created by elaine wang on 10/24/23.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var goalRepository = GoalRepository()
    var body: some View {
      goalRepository.goals.compactMap({ goal in
        print(goal)
      })
      print("hello")
      return Text("Hello")
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
