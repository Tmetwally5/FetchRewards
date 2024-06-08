import SwiftUI
import Combine

/**
 The `MealsViewModel` class serves as the view model for managing and fetching meal data and categories.
 
 It conforms to the `ObservableObject` protocol, making it suitable for use with SwiftUI views. The view model interacts with a `NetworkService` to fetch data from the API.
 */
class MealsViewModel: ObservableObject {
    /// Published property for holding a list of meals, which can be observed by SwiftUI views.
    @Published var meals: [Meal] = []
    
    /// Published property for holding a list of categories, which can be observed by SwiftUI views.
    @Published var categories: [Category] = []
    
    /// Set to hold any cancellable Combine publishers to manage memory and lifecycle.
    private var cancellables = Set<AnyCancellable>()
    
    /// Instance of `NetworkService` used for network requests.
    let networkService: NetworkService
    
    /**
     Initializes the view model with a given network service.
     
     - Parameter networkService: The network service to be used for fetching data.
     */
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    /**
     Fetches meals based on the given search option and query.
     
     The method sends a network request to fetch meals and updates the `meals` property with the fetched data. The results are sorted alphabetically.
     
     - Parameters:
        - searchOption: The search option to be used (category, name, ingredient, or area).
        - query: The query string for the search.
     */
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
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.meals = []
                    print("Failed to fetch meal detail: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] response in
                self?.meals = response.meals
                    .compactMap { $0 }
                    .sorted { ($0.strMeal ?? "") < ($1.strMeal ?? "") }
            })
            .store(in: &cancellables)
    }
    
    /**
     Fetches categories from the API.
     
     The method sends a network request to fetch categories and updates the `categories` property with the fetched data. The results are sorted alphabetically.
     */
    func fetchCategories() {
        networkService.fetchCategories()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Failed to fetch categories: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] response in
                self?.categories = response.categories
                    .compactMap { $0 }
                    
            })
            .store(in: &cancellables)
    }
}
