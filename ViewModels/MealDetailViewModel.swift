//
//  MealDetailViewModel.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import SwiftUI
import Combine

class MealDetailViewModel: ObservableObject {
    
    @Published var meal: MealDetails? = nil
    @Published var errorMessage: String? = nil
    private var cancellables = Set<AnyCancellable>()
    private var networkService:NetworkService
    
    init(networkService:NetworkService) {
        self.networkService = networkService
    }
    
    func fetchMealDetail(byId id: String) {
        networkService.fetchMealDetailsByID(meal_ID: id)
            .receive(on: DispatchQueue.global())
            .handleEvents(receiveSubscription: {[weak self] _ in
                self?.errorMessage = nil // Clear previous errors
            })
            .sink(receiveCompletion: {[weak self] completion in
                if case let .failure(error) = completion {
                    self?.errorMessage = "Failed to fetch meal detail: \(error.localizedDescription)"
                }
            }, receiveValue: {[weak self] response in
                self?.meal = response.meals.first
            })
            .store(in: &cancellables)
    }
}


