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
}

extension MyAPI: TargetType {
    var baseURL: URL { return URL(string: "https://themealdb.com/api/json/v1/1/")! }
    
    var path: String {
        switch self {
        case .fetchMealDetailsByID:
            return "lookup.php"
        case .fetchMealListByCategory:
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
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    var sampleData: Data {
        return Data()
    }
}
