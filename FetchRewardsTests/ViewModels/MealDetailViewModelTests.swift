//
//  MealDetailViewModelTests.swift
//  FetchRewardsTests
//
//  Created by Taha Metwally on 8/6/2024.
//

import XCTest
import Combine
import Moya

@testable import FetchRewards

class MealDetailViewModelTests: XCTestCase {

    class MockNetworkService: NetworkService {
        
        var shouldFail = false
        
        func getMealDetails()->MealDetails{
            return MealDetails(idMeal: "1",
                               strMeal: "Spaghetti",
                               strMealThumb: "https://www.example.com/spaghetti.jpg",
                               strTags: "Italian, Pasta",
                               strYoutube: "https://www.youtube.com/watch?v=abc123",
                               strDrinkAlternate: "Soda",
                               strCategory: "Main Course",
                               strArea: "Italian", strInstructions: "Boil pasta and serve with sauce.", strIngredient1: "Pasta", strIngredient2: "Tomato Sauce", strIngredient3: nil, strIngredient4: nil, strIngredient5: nil, strIngredient6: nil, strIngredient7: nil, strIngredient8: nil, strIngredient9: nil, strIngredient10: nil, strIngredient11: nil, strIngredient12: nil, strIngredient13: nil, strIngredient14: nil, strIngredient15: nil, strIngredient16: nil, strIngredient17: nil, strIngredient18: nil, strIngredient19: nil, strIngredient20: nil, strMeasure1: "1 cup", strMeasure2: "1 can", strMeasure3: nil, strMeasure4: nil, strMeasure5: nil, strMeasure6: nil, strMeasure7: nil, strMeasure8: nil, strMeasure9: nil, strMeasure10: nil, strMeasure11: nil, strMeasure12: nil, strMeasure13: nil, strMeasure14: nil, strMeasure15: nil, strMeasure16: nil, strMeasure17: nil, strMeasure18: nil, strMeasure19: nil, strMeasure20: nil)
        }
        
        override func fetchMealDetailsByID(mealID: String) -> AnyPublisher<MealDetailsResponse, Error> {
            if shouldFail {
                return Fail(error: NSError(domain: "TestError", code: 123, userInfo: nil)).eraseToAnyPublisher()
            } else {
                let mealsResponse = MealDetailsResponse(meals: [getMealDetails()])
                return Result.Publisher(mealsResponse).eraseToAnyPublisher()
            }
        }
    }

    func testFetchMealDetailSuccess() {
        testFetchMealDetail(shouldFail: false)
    }

    func testFetchMealDetailFailure() {
        testFetchMealDetail(shouldFail: true)
    }
    
    func testFetchMealDetail(shouldFail: Bool) {
        let viewModel = MealDetailViewModel(networkService: MockNetworkService(provider: MoyaProvider<MyAPI>()))
        (viewModel.networkService as? MockNetworkService)?.shouldFail = shouldFail
        let mealID = "123"
        let expectation = self.expectation(description: "Fetch meal detail")
        viewModel.fetchMealDetail(byId: mealID)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if shouldFail {
                XCTAssertNil(viewModel.meal)
            } else {
                XCTAssertEqual(viewModel.meal?.idMeal, "1")
                XCTAssertEqual(viewModel.meal?.strMeal, "Spaghetti")
                XCTAssertEqual(viewModel.meal?.strMealThumb, "https://www.example.com/spaghetti.jpg")
                XCTAssertEqual(viewModel.meal?.strYoutube, "https://www.youtube.com/watch?v=abc123")
                XCTAssertEqual(viewModel.meal?.strDrinkAlternate, "Soda")
                XCTAssertEqual(viewModel.meal?.strCategory, "Main Course")
                XCTAssertEqual(viewModel.meal?.strArea, "Italian")
                XCTAssertEqual(viewModel.meal?.strInstructions, "Boil pasta and serve with sauce.")
                XCTAssertEqual(viewModel.meal?.strIngredient1, "Pasta")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)
    }

}
