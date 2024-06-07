//
//  NetworkService.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//
import Combine
import Moya

class NetworkService {
    
    private let provider = MoyaProvider<MyAPI>()

    func fetchMealListByCategory(category: String) -> AnyPublisher<MealsResponse, Error> {
        return provider.requestPublisher(.fetchMealListByCategory(category: category))
            .map(MealsResponse.self)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    func fetchMealDetailsByID(meal_ID : String) -> AnyPublisher<MealDetailsResponse, Error> {
        return provider.requestPublisher(.fetchMealDetailsByID(meal_ID: meal_ID))
            .map(MealDetailsResponse.self)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    func fetchMealListByName(name : String) -> AnyPublisher<MealsResponse, Error> {
        return provider.requestPublisher(.fetchMealListByName(name: name))
            .map(MealsResponse.self)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    func fetchMealListByIngredient(ingredient : String) -> AnyPublisher<MealsResponse, Error> {
        return provider.requestPublisher(.fetchMealListByIngredient(ingredient: ingredient))
            .map(MealsResponse.self)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    func fetchMealListByCountry(country : String) -> AnyPublisher<MealsResponse, Error> {
        return provider.requestPublisher(.fetchMealListByCountry(country: country))
            .map(MealsResponse.self)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
