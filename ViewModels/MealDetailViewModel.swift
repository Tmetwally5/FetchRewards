//
//  MealDetailViewModel.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import SwiftUI
import Combine

/**
 The `MealDetailViewModel` class is a view model that manages the fetching and storage of detailed meal information.
 
 This class conforms to the `ObservableObject` protocol, allowing SwiftUI views to observe its properties and update accordingly.
 */
class MealDetailViewModel: ObservableObject {
    
    /// Published property for holding the details of a meal, which can be observed by SwiftUI views.
    @Published var meal: MealDetails? = nil
    
    /// Set to hold any cancellable Combine publishers to manage memory and lifecycle.
    private var cancellables = Set<AnyCancellable>()
    
    /// Instance of `NetworkService` used for network requests.
    var networkService: NetworkService
    
    /**
     Initializes the view model with a given network service.
     
     - Parameter networkService: The network service to be used for fetching data.
     */
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    /**
     Fetches the details of a meal by its ID.
     
     The method sends a network request to fetch meal details and updates the `meal` property with the fetched data.
     
     - Parameter id: The ID of the meal to fetch details for.
     */
    func fetchMealDetail(byId id: String) {
        networkService.fetchMealDetailsByID(mealID: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Failed to fetch meal detail: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] response in
                self?.meal = response.meals.first
            })
            .store(in: &cancellables)
    }
}
