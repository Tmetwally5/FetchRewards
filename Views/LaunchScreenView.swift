//
//  ContentView.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//
import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("launch_image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            Spacer()
        }
    }
}
