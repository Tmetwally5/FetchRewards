//
//  AppDependencies.swift
//  FetchRewards
//
//  Created by Taha Metwally on 7/6/2024.
//


import SwiftUI
class AppDependencies: ObservableObject {

    @Published var mealDetailViewModel: MealDetailViewModel
    @Published var mealsViewModel: MealsViewModel
    @Published var reachability: Reachability
    let networkService:NetworkService

    init() {
        // Initialize your dependencies
        self.networkService = NetworkService()
        self.mealDetailViewModel = MealDetailViewModel(networkService: networkService)
        self.mealsViewModel = MealsViewModel(networkService: networkService)
        self.reachability = Reachability()
    }
}

