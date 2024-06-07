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

    func fetchMealListByCategory(category : String) -> AnyPublisher<MealsResponse, Error> {
       
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
}
