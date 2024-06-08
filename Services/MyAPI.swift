//
//  MyAPI.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import Combine
import Moya

/**
 The `MyAPI` enum defines different endpoints and their associated parameters for making requests to the meal database API (https://www.themealdb.com/api/json/v1/1/).
 
 Each case in the enum represents a specific API endpoint along with the required parameters for that endpoint.
 */
enum MyAPI {
    case fetchMealDetailsByID(mealID: String)
    case fetchMealListByCategory(category: String)
    case fetchMealListByName(name: String)
    case fetchMealListByIngredient(ingredient: String)
    case fetchMealListByCountry(country: String)
    case fetchCategories
}

extension MyAPI: TargetType {
    /// The base URL for all API requests.
    var baseURL: URL {
        return URL(string: "https://www.themealdb.com/api/json/v1/1/")!
    }
    
    /// The path component of the URL for each API request.
    var path: String {
        switch self {
        case .fetchMealDetailsByID:
            return "lookup.php"
        case .fetchMealListByCategory:
            return "filter.php"
        case .fetchMealListByName:
            return "search.php"
        case .fetchMealListByIngredient:
            return "filter.php"
        case .fetchMealListByCountry:
            return "filter.php"
        case .fetchCategories:
            return "categories.php"
        }
    }
    
    /// The HTTP method used for each API request.
    var method: Moya.Method {
        return .get
    }
    
    /// The task to be performed for each API request, including parameters and encoding.
    var task: Task {
        switch self {
        case .fetchMealDetailsByID(let mealID):
            return .requestParameters(parameters: ["i": mealID], encoding: URLEncoding.default)
        case .fetchMealListByCategory(let category):
            return .requestParameters(parameters: ["c": category], encoding: URLEncoding.default)
        case .fetchMealListByName(let name):
            return .requestParameters(parameters: ["s": name], encoding: URLEncoding.default)
        case .fetchMealListByIngredient(let ingredient):
            return .requestParameters(parameters: ["i": ingredient], encoding: URLEncoding.default)
        case .fetchMealListByCountry(let country):
            return .requestParameters(parameters: ["a": country], encoding: URLEncoding.default)
        case .fetchCategories:
            return .requestPlain
        }
    }
    
    /// The HTTP headers for each API request.
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    /// Sample data to be used for testing purposes.
    var sampleData: Data {
        return Data()
    }
}
