// MealDetailsResponseTests.swift

import XCTest
@testable import FetchRewards

class MealDetailsResponseTests: XCTestCase {
    
    func testDecodeMealDetailsResponse() throws {
        // Given
        let json = """
        {
            "meals": [
                {
                    "idMeal": "1",
                    "strMeal": "Spaghetti",
                    "strMealThumb": "https://www.example.com/spaghetti.jpg",
                    "strTags": "Italian, Pasta",
                    "strYoutube": "https://www.youtube.com/watch?v=abc123",
                    "strDrinkAlternate": "Soda",
                    "strCategory": "Main Course",
                    "strArea": "Italian",
                    "strInstructions": "Boil pasta and serve with sauce.",
                    "strIngredient1": "Pasta",
                    "strMeasure1": "1 cup",
                    "strIngredient2": "Tomato Sauce",
                    "strMeasure2": "1 can"
                }
            ]
        }
        """.data(using: .utf8)!
        
        // When
        let mealDetailsResponse = try JSONDecoder().decode(MealDetailsResponse.self, from: json)
        
        // Then
        XCTAssertEqual(mealDetailsResponse.meals.count, 1)
        XCTAssertEqual(mealDetailsResponse.meals[0].idMeal, "1")
        XCTAssertEqual(mealDetailsResponse.meals[0].strMeal, "Spaghetti")
        XCTAssertEqual(mealDetailsResponse.meals[0].strMealThumb, "https://www.example.com/spaghetti.jpg")
        XCTAssertEqual(mealDetailsResponse.meals[0].strTags, "Italian, Pasta")
        XCTAssertEqual(mealDetailsResponse.meals[0].strYoutube, "https://www.youtube.com/watch?v=abc123")
        XCTAssertEqual(mealDetailsResponse.meals[0].strDrinkAlternate, "Soda")
        XCTAssertEqual(mealDetailsResponse.meals[0].strCategory, "Main Course")
        XCTAssertEqual(mealDetailsResponse.meals[0].strArea, "Italian")
        XCTAssertEqual(mealDetailsResponse.meals[0].strInstructions, "Boil pasta and serve with sauce.")
        XCTAssertEqual(mealDetailsResponse.meals[0].strIngredient1, "Pasta")
        XCTAssertEqual(mealDetailsResponse.meals[0].strMeasure1, "1 cup")
        XCTAssertEqual(mealDetailsResponse.meals[0].strIngredient2, "Tomato Sauce")
        XCTAssertEqual(mealDetailsResponse.meals[0].strMeasure2, "1 can")

    }
    
}

class MealDetailsTests: XCTestCase {
    
    func testGetIngredientMeasurementList() {
        // Given

        
        let mealDetails = MealDetails(idMeal: "1",
                            strMeal: "Spaghetti",
                            strMealThumb: "https://www.example.com/spaghetti.jpg",
                            strTags: "Italian, Pasta",
                            strYoutube: "https://www.youtube.com/watch?v=abc123",
                            strDrinkAlternate: "Soda",
                            strCategory: "Main Course",
                            strArea: "Italian", strInstructions: "Boil pasta and serve with sauce.", strIngredient1: "Pasta", strIngredient2: "Tomato Sauce", strIngredient3: nil, strIngredient4: nil, strIngredient5: nil, strIngredient6: nil, strIngredient7: nil, strIngredient8: nil, strIngredient9: nil, strIngredient10: nil, strIngredient11: nil, strIngredient12: nil, strIngredient13: nil, strIngredient14: nil, strIngredient15: nil, strIngredient16: nil, strIngredient17: nil, strIngredient18: nil, strIngredient19: nil, strIngredient20: nil, strMeasure1: "1 cup", strMeasure2: "1 can", strMeasure3: nil, strMeasure4: nil, strMeasure5: nil, strMeasure6: nil, strMeasure7: nil, strMeasure8: nil, strMeasure9: nil, strMeasure10: nil, strMeasure11: nil, strMeasure12: nil, strMeasure13: nil, strMeasure14: nil, strMeasure15: nil, strMeasure16: nil, strMeasure17: nil, strMeasure18: nil, strMeasure19: nil, strMeasure20: nil)
        
        
        
        
        // When
        let ingredientMeasurementList = mealDetails.getIngredientMeasurementList()
        
        // Then
        XCTAssertEqual(ingredientMeasurementList.count, 2)
        XCTAssertEqual(ingredientMeasurementList[0].0, "Pasta")
        XCTAssertEqual(ingredientMeasurementList[0].1, "1 cup")
        XCTAssertEqual(ingredientMeasurementList[1].0, "Tomato Sauce")
        XCTAssertEqual(ingredientMeasurementList[1].1, "1 can")
    }
    
}
