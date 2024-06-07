//
//  MyAPI.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//
import Combine
import Moya

enum MyAPI {
    case fetchMealDetailsByID(mealID: String)
    case fetchMealListByCategory(category: String)
    case fetchMealListByName(name: String)
    case fetchMealListByIngredient(ingredient: String)
    case fetchMealListByCountry(country: String)
    case fetchCategories
}

extension MyAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.themealdb.com/api/json/v1/1/")!
    }
    
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
    
    var method: Moya.Method {
        return .get
    }
    
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
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var sampleData: Data {
        return Data()
    }
}
