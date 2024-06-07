import SwiftUI
import Combine

class MealsViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchMeals(searchOption: SearchOption, query: String) {
        let publisher: AnyPublisher<MealsResponse, Error>
        
        switch searchOption {
        case .category:
            publisher = networkService.fetchMealListByCategory(category: query)
        case .name:
            publisher = networkService.fetchMealListByName(name: query)
        case .ingredient:
            publisher = networkService.fetchMealListByIngredient(ingredient: query)
        case .area:
            publisher = networkService.fetchMealListByCountry(country: query)
        }
        
        publisher
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.errorMessage = nil
            })
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.errorMessage = "Failed to fetch meal detail: \(error.localizedDescription)"
                }
            }, receiveValue: { [weak self] response in
                self?.meals = response.meals
                    .compactMap { $0 }
                    .sorted { ($0.strMeal ?? "") < ($1.strMeal ?? "") }
            })
            .store(in: &cancellables)
    }
}
