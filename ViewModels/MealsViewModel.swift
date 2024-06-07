//
//  MealsViewModel.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import SwiftUI
import Combine

class MealsViewModel: ObservableObject {
    
    @Published var meals: [Meal] = []
    private var cancellables = Set<AnyCancellable>()
    private var networkService:NetworkService
    @Published var errorMessage: String? = nil
    
    init(networkService:NetworkService) {
        self.networkService = networkService
    }

    func fetchMeals(category:String) {
        networkService.fetchMealListByCategory(category: category)
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveSubscription: {[weak self] _ in
                self?.errorMessage = nil // Clear previous errors
            })
            .sink(receiveCompletion: {[weak self] completion in
                
                if case let .failure(error) = completion {
                    self?.errorMessage = "Failed to fetch meal detail: \(error.localizedDescription)"
                }
            }, receiveValue: {[weak self] response in
                self?.meals = response.meals
                                   .compactMap { $0 } // Ensure meals are non-nil
                                   .sorted { ($0.strMeal ?? "") < ($1.strMeal ?? "") }
            }).store(in: &cancellables)
    }
}
