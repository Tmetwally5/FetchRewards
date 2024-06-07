//
//  NetworkService.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//
import Combine
import Moya
import Combine
import Moya

class NetworkService {
    
    private let provider = MoyaProvider<MyAPI>()
    
    private func request<T: Decodable>(_ target: MyAPI, type: T.Type) -> AnyPublisher<T, Error> {
        return provider.requestPublisher(target)
            .map(T.self)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }

    func fetchMealListByCategory(category: String) -> AnyPublisher<MealsResponse, Error> {
        return request(.fetchMealListByCategory(category: category), type: MealsResponse.self)
    }
    
    func fetchMealDetailsByID(mealID: String) -> AnyPublisher<MealDetailsResponse, Error> {
        return request(.fetchMealDetailsByID(mealID: mealID), type: MealDetailsResponse.self)
    }
    
    func fetchMealListByName(name: String) -> AnyPublisher<MealsResponse, Error> {
        return request(.fetchMealListByName(name: name), type: MealsResponse.self)
    }
    
    func fetchMealListByIngredient(ingredient: String) -> AnyPublisher<MealsResponse, Error> {
        return request(.fetchMealListByIngredient(ingredient: ingredient), type: MealsResponse.self)
    }
    
    func fetchMealListByCountry(country: String) -> AnyPublisher<MealsResponse, Error> {
        return request(.fetchMealListByCountry(country: country), type: MealsResponse.self)
    }
    
    func fetchCategories() -> AnyPublisher<CategoriesResponse, Error> {
        return request(.fetchCategories, type: CategoriesResponse.self)
    }
}
