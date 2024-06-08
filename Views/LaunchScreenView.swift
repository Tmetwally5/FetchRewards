//
//  ContentView.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import SwiftUI

/**
 The `LaunchScreenView` struct represents the launch screen of the application, typically displayed when the app is launching.
 
 It displays an image with the name "launch_image" in the center of the screen, adjusting its aspect ratio to fit the available space.
 */
struct LaunchScreenView: View {
    
    var body: some View {
        VStack {
            Spacer()
            Image("launch_image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            Spacer()
        }.accessibility(identifier: "launch_screen")
    }
}
