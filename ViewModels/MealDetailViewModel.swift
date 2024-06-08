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
    private var cancellables = Set<AnyCancellable>()
    private var networkService:NetworkService
    
    init(networkService:NetworkService) {
        self.networkService = networkService
    }
    
    func fetchMealDetail(byId id: String) {
        networkService.fetchMealDetailsByID(mealID: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Failed to fetch meal detail: \(error.localizedDescription)")
                }
            }, receiveValue: {[weak self] response in
                self?.meal = response.meals.first
            })
            .store(in: &cancellables)
    }
}
