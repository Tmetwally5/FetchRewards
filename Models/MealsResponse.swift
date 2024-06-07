//
//  MealsResponse.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import Foundation

// MARK: - MealsResponse
struct MealsResponse: Codable {
    let meals: [Meal]
}

// MARK: - Meal
struct Meal: Codable, Identifiable {
    let id: String?
    let strMeal: String?
    let strMealThumb: String?

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case strMeal
        case strMealThumb
    }
}
