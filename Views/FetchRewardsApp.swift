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
    @State private var showLaunchScreen = true
    
    var body: some Scene {
        WindowGroup {
            if showLaunchScreen {
                LaunchScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { 
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
