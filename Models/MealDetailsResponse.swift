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
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let strIngredient1: String?
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
            
            let ingredient = self.value(for: ingredientKey) as? String ?? ""
            let measure = self.value(for: measureKey) as? String ?? ""
            
            if !ingredient.isEmpty {
                list.append((ingredient, measure))
            }
        }
        return list
    }
    func getIngrediantMessurementList()->[(String,String)]{
        var list:[(String,String)] = []
        if let strIngredient1 = strIngredient1,let strMeasure1 = strMeasure1{
            list.append((strIngredient1,strMeasure1))
        }
        if let strIngredient2 = strIngredient2,let strMeasure2 = strMeasure2{
            list.append((strIngredient2,strMeasure2))
        }
        if let strIngredient3 = strIngredient3,let strMeasure3 = strMeasure3{
            list.append((strIngredient3,strMeasure3))
        }
        if let strIngredient4 = strIngredient4,let strMeasure4 = strMeasure4{
            list.append((strIngredient4,strMeasure4))
        }
        if let strIngredient5 = strIngredient5,let strMeasure5 = strMeasure5{
            list.append((strIngredient5,strMeasure5))
        }
        if let strIngredient6 = strIngredient6,let strMeasure6 = strMeasure6{
            list.append((strIngredient6,strMeasure6))
        }
        if let strIngredient7 = strIngredient7,let strMeasure7 = strMeasure7{
            list.append((strIngredient7,strMeasure7))
        }
        if let strIngredient8 = strIngredient8,let strMeasure8 = strMeasure8{
            list.append((strIngredient8,strMeasure8))
        }
        if let strIngredient9 = strIngredient9,let strMeasure9 = strMeasure9{
            list.append((strIngredient9,strMeasure9))
        }
        if let strIngredient10 = strIngredient10,let strMeasure10 = strMeasure10{
            list.append((strIngredient10,strMeasure10))
        }
        if let strIngredient11 = strIngredient11,let strMeasure11 = strMeasure11{
            list.append((strIngredient11,strMeasure11))
        }
        if let strIngredient12 = strIngredient12,let strMeasure12 = strMeasure12{
            list.append((strIngredient12,strMeasure12))
        }
        if let strIngredient13 = strIngredient13,let strMeasure13 = strMeasure13{
            list.append((strIngredient13,strMeasure13))
        }
        if let strIngredient14 = strIngredient14,let strMeasure14 = strMeasure14{
            list.append((strIngredient14,strMeasure14))
        }
        if let strIngredient15 = strIngredient15,let strMeasure15 = strMeasure15{
            list.append((strIngredient15,strMeasure15))
        }
        if let strIngredient16 = strIngredient16,let strMeasure16 = strMeasure16{
            list.append((strIngredient16,strMeasure16))
        }
        if let strIngredient17 = strIngredient17,let strMeasure17 = strMeasure17{
            list.append((strIngredient17,strMeasure17))
        }
        if let strIngredient18 = strIngredient18,let strMeasure18 = strMeasure18{
            list.append((strIngredient18,strMeasure18))
        }
        if let strIngredient19 = strIngredient19,let strMeasure19 = strMeasure19{
            list.append((strIngredient19,strMeasure19))
        }
        if let strIngredient20 = strIngredient20,let strMeasure20 = strMeasure20{
            list.append((strIngredient20,strMeasure20))
        }
        
        return list
        
    }
}
