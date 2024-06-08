//
//  AppDependencies.swift
//  FetchRewards
//
//  Created by Taha Metwally on 7/6/2024.
//

import SwiftUI
import Moya
import Network

/**
 A class that manages the dependencies of the FetchRewards application, making it easier to inject and manage dependencies throughout the app.

 - Note: This class conforms to `ObservableObject`, which means it can be observed for changes in its published properties.
 */
class AppDependencies: ObservableObject {

    /// A published property that provides the `MealDetailViewModel` instance.
    @Published var mealDetailViewModel: MealDetailViewModel

    /// A published property that provides the `MealsViewModel` instance.
    @Published var mealsViewModel: MealsViewModel

    /// A published property that provides the `Reachability` instance for monitoring network connectivity.
    @Published var reachability: Reachability

    /// The `NetworkService` instance used to manage network requests.
    let networkService: NetworkService

    /// The `MoyaProvider` instance used to handle API requests.
    let moyaProvider: MoyaProvider<MyAPI>

    /// The `NWPathMonitor` instance used to monitor network path changes.
    let monitor: NWPathMonitor

    /**
     Initializes a new `AppDependencies` instance, setting up all necessary dependencies for the application.
     */
    init() {
        // Initialize MoyaProvider with the specified API
        self.moyaProvider = MoyaProvider<MyAPI>()
        
        // Initialize NetworkService with the MoyaProvider
        self.networkService = NetworkService(provider: moyaProvider)
        
        // Initialize MealDetailViewModel with the NetworkService
        self.mealDetailViewModel = MealDetailViewModel(networkService: networkService)
        
        // Initialize MealsViewModel with the NetworkService
        self.mealsViewModel = MealsViewModel(networkService: networkService)
        
        // Initialize NWPathMonitor for monitoring network connectivity
        self.monitor = NWPathMonitor()
        
        // Initialize Reachability with the NWPathMonitor
        self.reachability = Reachability(monitor: monitor)
    }
}
