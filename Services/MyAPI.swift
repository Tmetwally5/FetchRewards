//
//  MyAPI.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//


import Combine
import Moya

enum MyAPI {
    case fetchMealDetailsByID(meal_ID : String)
    case fetchMealListByCategory(category:String)
    case fetchMealListByName(name:String)
    case fetchMealListByIngredient(ingredient:String)
    case fetchMealListByCountry(country:String)
    
}

extension MyAPI: TargetType {
    var baseURL: URL { return URL(string: "https://themealdb.com/api/json/v1/1/")! }
    
    var path: String {
        switch self {
        case .fetchMealDetailsByID:
            return "lookup.php"
        case .fetchMealListByCategory:
            return "filter.php"
        case .fetchMealListByName:
            return "search.php"
        case .fetchMealListByIngredient(ingredient: let ingredient):
            return "filter.php"
        case .fetchMealListByCountry(country: let country):
            return "filter.php"
        }
    }
    var method: Moya.Method {
        return .get
    }
    var task: Task {
        switch self {
        case .fetchMealDetailsByID(let mealID):
            return .requestParameters(parameters: ["i": mealID], encoding: URLEncoding.default)
        case .fetchMealListByCategory(let category):
            return .requestParameters(parameters: ["c": category], encoding: URLEncoding.default)
        case .fetchMealListByName(name: let name):
            return .requestParameters(parameters: ["s": name], encoding: URLEncoding.default)
        case .fetchMealListByIngredient(ingredient: let ingredient):
            return .requestParameters(parameters: ["i": ingredient], encoding: URLEncoding.default)
        case .fetchMealListByCountry(country: let country):
            return .requestParameters(parameters: ["a": country], encoding: URLEncoding.default)
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    var sampleData: Data {
        return Data()
    }
}
