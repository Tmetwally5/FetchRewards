//
//  NetworkService.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import Combine
import Moya

/**
 The `NetworkService` class provides methods for making network requests to fetch meal-related data using the Moya framework.

 This class uses Combine for handling asynchronous data streams and Moya for network abstraction.
 */
class NetworkService {
    
    /// The Moya provider used for making network requests.
    private let provider: MoyaProvider<MyAPI>
    
    /**
     Initializes the network service with a given Moya provider.
     
     - Parameter provider: The Moya provider to be used for making network requests.
     */
    init(provider: MoyaProvider<MyAPI>) {
        self.provider = provider
    }
    
    /**
     A generic method to make network requests and decode the response.
     
     - Parameters:
       - target: The API endpoint to request.
       - type: The type of the expected response, conforming to `Decodable`.
     - Returns: A publisher that outputs the decoded response or an error.
     */
    private func request<T: Decodable>(_ target: MyAPI, type: T.Type) -> AnyPublisher<T, Error> {
        return provider.requestPublisher(target)
            .map(T.self)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }

    /**
     Fetches the list of meals by category.
     
     - Parameter category: The category of meals to fetch.
     - Returns: A publisher that outputs a `MealsResponse` or an error.
     */
    func fetchMealListByCategory(category: String) -> AnyPublisher<MealsResponse, Error> {
        return request(.fetchMealListByCategory(category: category), type: MealsResponse.self)
    }
    
    /**
     Fetches the details of a meal by its ID.
     
     - Parameter mealID: The ID of the meal to fetch details for.
     - Returns: A publisher that outputs a `MealDetailsResponse` or an error.
     */
    func fetchMealDetailsByID(mealID: String) -> AnyPublisher<MealDetailsResponse, Error> {
        return request(.fetchMealDetailsByID(mealID: mealID), type: MealDetailsResponse.self)
    }
    
    /**
     Fetches the list of meals by name.
     
     - Parameter name: The name of the meals to fetch.
     - Returns: A publisher that outputs a `MealsResponse` or an error.
     */
    func fetchMealListByName(name: String) -> AnyPublisher<MealsResponse, Error> {
        return request(.fetchMealListByName(name: name), type: MealsResponse.self)
    }
    
    /**
     Fetches the list of meals by ingredient.
     
     - Parameter ingredient: The ingredient of the meals to fetch.
     - Returns: A publisher that outputs a `MealsResponse` or an error.
     */
    func fetchMealListByIngredient(ingredient: String) -> AnyPublisher<MealsResponse, Error> {
        return request(.fetchMealListByIngredient(ingredient: ingredient), type: MealsResponse.self)
    }
    
    /**
     Fetches the list of meals by country.
     
     - Parameter country: The country of the meals to fetch.
     - Returns: A publisher that outputs a `MealsResponse` or an error.
     */
    func fetchMealListByCountry(country: String) -> AnyPublisher<MealsResponse, Error> {
        return request(.fetchMealListByCountry(country: country), type: MealsResponse.self)
    }
    
    /**
     Fetches the list of meal categories.
     
     - Returns: A publisher that outputs a `CategoriesResponse` or an error.
     */
    func fetchCategories() -> AnyPublisher<CategoriesResponse, Error> {
        return request(.fetchCategories, type: CategoriesResponse.self)
    }
}
