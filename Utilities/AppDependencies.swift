//
//  AppDependencies.swift
//  FetchRewards
//
//  Created by Taha Metwally on 7/6/2024.
//


import SwiftUI
import Moya
import Network

class AppDependencies: ObservableObject {

    @Published var mealDetailViewModel: MealDetailViewModel
    @Published var mealsViewModel: MealsViewModel
    @Published var reachability: Reachability
    let networkService:NetworkService
    let moyaProvider:MoyaProvider<MyAPI>
    var  monitor: NWPathMonitor

    init() {
        self.moyaProvider = MoyaProvider<MyAPI>()
        self.networkService = NetworkService(provider: moyaProvider)
        self.mealDetailViewModel = MealDetailViewModel(networkService: networkService)
        self.mealsViewModel = MealsViewModel(networkService: networkService)
        self.monitor = NWPathMonitor()
        self.reachability = Reachability(monitor: monitor)
    }
}

