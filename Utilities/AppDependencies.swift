//
//  AppDependencies.swift
//  FetchRewards
//
//  Created by Taha Metwally on 7/6/2024.
//


import SwiftUI
class AppDependencies: ObservableObject {
    // Define your dependencies
    let mealDetailViewModel = MealDetailViewModel(networkService: NetworkService())
    let mealsViewModel = MealsViewModel(networkService: NetworkService())
    let reachability = Reachability()
}
