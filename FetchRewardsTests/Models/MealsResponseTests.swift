//

//  FetchRewardsTests
//
//  Created by Taha Metwally on 8/6/2024.
//
import XCTest
@testable import FetchRewards

class MealsResponseTests: XCTestCase {
    
    func testDecodeMealsResponse() throws {
        // Given
        let json = """
        {
            "meals": [
                {
                    "idMeal": "1",
                    "strMeal": "Pasta",
                    "strMealThumb": "https://www.example.com/pasta.jpg"
                },
                {
                    "idMeal": "2",
                    "strMeal": "Pizza",
                    "strMealThumb": "https://www.example.com/pizza.jpg"
                }
            ]
        }
        """.data(using: .utf8)!
        
        // When
        let mealsResponse = try JSONDecoder().decode(MealsResponse.self, from: json)
        
        // Then
        XCTAssertEqual(mealsResponse.meals.count, 2)
        XCTAssertEqual(mealsResponse.meals[0].id, "1")
        XCTAssertEqual(mealsResponse.meals[0].strMeal, "Pasta")
        XCTAssertEqual(mealsResponse.meals[0].strMealThumb, "https://www.example.com/pasta.jpg")
        XCTAssertEqual(mealsResponse.meals[1].id, "2")
        XCTAssertEqual(mealsResponse.meals[1].strMeal, "Pizza")
        XCTAssertEqual(mealsResponse.meals[1].strMealThumb, "https://www.example.com/pizza.jpg")
    }
    
}

class MealTests: XCTestCase {
    
    func testDecodeMeal() throws {
        // Given
        let json = """
        {
            "idMeal": "1",
            "strMeal": "Pasta",
            "strMealThumb": "https://www.example.com/pasta.jpg"
        }
        """.data(using: .utf8)!
        
        // When
        let meal = try JSONDecoder().decode(Meal.self, from: json)
        
        // Then
        XCTAssertEqual(meal.id, "1")
        XCTAssertEqual(meal.strMeal, "Pasta")
        XCTAssertEqual(meal.strMealThumb, "https://www.example.com/pasta.jpg")
    }
    
}
