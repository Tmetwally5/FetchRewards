//
//  MealDetailsResponse.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import Foundation

/**
 A structure representing the response from the meal details API.
 
 This structure conforms to the `Codable` protocol, making it easy to encode and decode from JSON.
 */
struct MealDetailsResponse: Codable {
    /// An array of `MealDetails` objects representing the meal details fetched from the API.
    let meals: [MealDetails]
}

/**
 A structure representing the details of a meal.
 
 This structure conforms to the `Codable` and `Identifiable` protocols. The `Identifiable` conformance allows it to be used easily in SwiftUI lists.
 */
struct MealDetails: Codable, Identifiable {
    /// A unique identifier for the meal, generated using UUID.
    var id: String {
        return UUID().uuidString
    }

    /// The unique identifier for the meal.
    let idMeal: String?
    
    /// The name of the meal.
    let strMeal: String?
    
    /// The instructions for preparing the meal.
    let strInstructions: String?
    
    /// The first ingredient for the meal.
    let strIngredient1: String?
    
    /// The second ingredient for the meal.
    let strIngredient2: String?
    
    /// The third ingredient for the meal.
    let strIngredient3: String?
    
    /// The fourth ingredient for the meal.
    let strIngredient4: String?
    
    /// The fifth ingredient for the meal.
    let strIngredient5: String?
    
    /// The sixth ingredient for the meal.
    let strIngredient6: String?
    
    /// The seventh ingredient for the meal.
    let strIngredient7: String?
    
    /// The eighth ingredient for the meal.
    let strIngredient8: String?
    
    /// The ninth ingredient for the meal.
    let strIngredient9: String?
    
    /// The tenth ingredient for the meal.
    let strIngredient10: String?
    
    /// The eleventh ingredient for the meal.
    let strIngredient11: String?
    
    /// The twelfth ingredient for the meal.
    let strIngredient12: String?
    
    /// The thirteenth ingredient for the meal.
    let strIngredient13: String?
    
    /// The fourteenth ingredient for the meal.
    let strIngredient14: String?
    
    /// The fifteenth ingredient for the meal.
    let strIngredient15: String?
    
    /// The sixteenth ingredient for the meal.
    let strIngredient16: String?
    
    /// The seventeenth ingredient for the meal.
    let strIngredient17: String?
    
    /// The eighteenth ingredient for the meal.
    let strIngredient18: String?
    
    /// The nineteenth ingredient for the meal.
    let strIngredient19: String?
    
    /// The twentieth ingredient for the meal.
    let strIngredient20: String?
    
    /// The measurement for the first ingredient.
    let strMeasure1: String?
    
    /// The measurement for the second ingredient.
    let strMeasure2: String?
    
    /// The measurement for the third ingredient.
    let strMeasure3: String?
    
    /// The measurement for the fourth ingredient.
    let strMeasure4: String?
    
    /// The measurement for the fifth ingredient.
    let strMeasure5: String?
    
    /// The measurement for the sixth ingredient.
    let strMeasure6: String?
    
    /// The measurement for the seventh ingredient.
    let strMeasure7: String?
    
    /// The measurement for the eighth ingredient.
    let strMeasure8: String?
    
    /// The measurement for the ninth ingredient.
    let strMeasure9: String?
    
    /// The measurement for the tenth ingredient.
    let strMeasure10: String?
    
    /// The measurement for the eleventh ingredient.
    let strMeasure11: String?
    
    /// The measurement for the twelfth ingredient.
    let strMeasure12: String?
    
    /// The measurement for the thirteenth ingredient.
    let strMeasure13: String?
    
    /// The measurement for the fourteenth ingredient.
    let strMeasure14: String?
    
    /// The measurement for the fifteenth ingredient.
    let strMeasure15: String?
    
    /// The measurement for the sixteenth ingredient.
    let strMeasure16: String?
    
    /// The measurement for the seventeenth ingredient.
    let strMeasure17: String?
    
    /// The measurement for the eighteenth ingredient.
    let strMeasure18: String?
    
    /// The measurement for the nineteenth ingredient.
    let strMeasure19: String?
    
    /// The measurement for the twentieth ingredient.
    let strMeasure20: String?

    /**
     Returns a list of tuples containing the ingredient and its corresponding measurement.
     
     - Returns: An array of tuples, each containing a `String` representing the ingredient and a `String` representing the measurement.
     */
    func getIngredientMeasurementList() -> [(String, String)] {
        var list: [(String, String)] = []
        
        for index in 1...20 {
            let ingredientKey = "strIngredient\(index)"
            let measureKey = "strMeasure\(index)"
            
            if let ingredient = self.value(forKey: ingredientKey) as? String,
               let measure = self.value(forKey: measureKey) as? String,
               !ingredient.isEmpty {
                list.append((ingredient, measure))
            }
        }
        
        return list
    }
    
    /**
     A helper function to get the value of a property using its name.
     
     - Parameter key: The name of the property to retrieve.
     - Returns: The value of the property, or `nil` if the property does not exist.
     */
    private func value(forKey key: String) -> Any? {
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            if child.label == key {
                return child.value
            }
        }
        return nil
    }
}
