//
//  MealDetailsResponse.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import Foundation


import Foundation

// MARK: - MealsResponse
struct MealDetailsResponse: Codable {
    let meals: [MealDetails]
}

// MARK: - Meal
struct MealDetails: Codable, Identifiable {
    var id: String {
        return UUID().uuidString
    }
    let idMeal: String?
    let strMeal: String?
    let strInstructions: String?
   private  let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    
    /// Get a list of ingredients along with their measurements
    func getIngredientMeasurementListxx() -> [(String, String)] {
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
