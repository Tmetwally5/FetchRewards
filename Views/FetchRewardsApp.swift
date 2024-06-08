//
//  FetchRewardsApp.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import SwiftUI

/**
 The `FetchRewardsApp` struct represents the main entry point of the SwiftUI application.
 
 It defines the structure and behavior of the application, including the initial view displayed to the user.
 */
@main
struct FetchRewardsApp: App {
    
    /// The state object representing the dependencies of the application.
    @StateObject private var appDependencies = AppDependencies()
    
    /// A state variable to control the visibility of the launch screen.
    @State private var showLaunchScreen = true
    
    /// The main content of the application, defining the structure and behavior of the UI.
    var body: some Scene {
        WindowGroup {
            if showLaunchScreen {
                LaunchScreenView()
                    .onAppear {
                        // Simulate a delay for the launch screen before transitioning to the main content.
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showLaunchScreen = false
                            }
                        }
                    }
            } else {
                // Display the main content of the application after the launch screen.
                MealsListView()
                    .environmentObject(appDependencies.mealDetailViewModel)
                    .environmentObject(appDependencies.mealsViewModel)
                    .environmentObject(appDependencies.reachability)
                    .environment(\.sizeCategory, .large)
            }
        }
    }
}
