//
//  MealsResponse.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import Foundation

/**
 A structure representing the response from the meals API.
 
 This structure conforms to the `Codable` protocol, making it easy to encode and decode from JSON.
 */
struct MealsResponse: Codable {
    /// An array of `Meal` objects representing the meals fetched from the API.
    let meals: [Meal]
}

/**
 A structure representing a meal.
 
 This structure conforms to the `Codable` and `Identifiable` protocols. The `Identifiable` conformance allows it to be used easily in SwiftUI lists.
 */
struct Meal: Codable, Identifiable {
    /// The unique identifier for the meal.
    let id: String?
    
    /// The name of the meal.
    let strMeal: String?

    /**
     Enumeration defining the keys used for encoding and decoding the `Meal` structure from JSON.
     
     This enumeration maps the JSON keys to the properties of the `Meal` structure.
     */
    enum CodingKeys: String, CodingKey {
        /// The unique identifier for the meal, mapped from the JSON key "idMeal".
        case id = "idMeal"
        
        /// The name of the meal, mapped directly from the JSON key "strMeal".
        case strMeal
        
    }
}
