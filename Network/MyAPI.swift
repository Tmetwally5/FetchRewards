//
//  MyAPI.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//


import Combine
import Moya

enum MyAPI {
    case getUsers
    case fetchMealDetailsByID(meal_ID : String)
    case fetchMealListByCategory(category:String)
}

extension MyAPI: TargetType {
    var baseURL: URL { return URL(string: "https://jsonplaceholder.typicode.com")! }
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        case .fetchMealDetailsByID:
            return "dd"
        case .fetchMealListByCategory:
            return ""
        }

    }
    var method: Method {
        switch self {
        case .getUsers:
            return .get
        case .fetchMealDetailsByID:
            return .get
        case .fetchMealListByCategory:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .getUsers:
            return .requestPlain
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
