//
//  FetchRewardsApp.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import SwiftUI

// Define your environment object class
class AppDependencies: ObservableObject {
    // Define your dependencies
    let mealDetailViewModel = MealDetailViewModel(networkService: NetworkService())
    let mealsViewModel = MealsViewModel(networkService: NetworkService())
    let reachability = Reachability()
}

@main
struct FetchRewardsApp: App {
    // Create an instance of your environment object
    @StateObject private var appDependencies = AppDependencies()

    var body: some Scene {
        WindowGroup {
            // Inject the environment object using environmentObject modifier
            ContentView()
                .environmentObject(appDependencies)
        }
    }
}
