//
//  FetchRewardsApp.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import SwiftUI

@main
struct FetchRewardsApp: App {
    @StateObject private var appDependencies = AppDependencies()
    @State private var showLaunchScreen = true // Track whether to show the Launch Screen
    
    var body: some Scene {
        WindowGroup {
            if showLaunchScreen {
                LaunchScreenView()
                    .onAppear {
                        // Use a Timer to hide the Launch Screen after a delay
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Adjust the duration as needed
                            withAnimation {
                                showLaunchScreen = false
                            }
                        }
                    }
            } else {
                MealsListView()
                    .environmentObject(appDependencies.mealDetailViewModel).environmentObject(appDependencies.mealsViewModel).environmentObject(appDependencies.reachability)
            }
        }
    }
}
