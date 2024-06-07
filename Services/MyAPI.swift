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
        case .fetchMealDetailsByID(let meal_ID):
            return "lookup.php?i=\(meal_ID)"
        case .fetchMealListByCategory(let category):
            return "filter.php?c=\(category)"
        }

    }
    var method: Moya.Method {
        switch self {
        case .fetchMealDetailsByID:
            return .get
        case .fetchMealListByCategory:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .fetchMealDetailsByID:
            return .requestPlain
        case .fetchMealListByCategory:
            return .requestPlain
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    var sampleData: Data {
        return Data()
    }
}
