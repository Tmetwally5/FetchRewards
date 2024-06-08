//
//  MealsViewModelTests.swift
//  FetchRewardsTests
//
//  Created by Taha Metwally on 8/6/2024.
//

import XCTest
import Combine
import Moya

@testable import FetchRewards

class MealsViewModelTests: XCTestCase {
    

    class MockNetworkService: NetworkService {
        override func fetchMealListByCategory(category: String) -> AnyPublisher<MealsResponse, Error> {
            let mealsResponse = MealsResponse(meals: getMealList())
            return Result.Publisher(mealsResponse).eraseToAnyPublisher()
        }
        
        override func fetchMealListByName(name: String) -> AnyPublisher<MealsResponse, Error> {
            let mealsResponse = MealsResponse(meals: getMealList())
            return Result.Publisher(mealsResponse).eraseToAnyPublisher()
        }
        
        override func fetchMealListByIngredient(ingredient: String) -> AnyPublisher<MealsResponse, Error> {
            let mealsResponse = MealsResponse(meals: getMealList())
            return Result.Publisher(mealsResponse).eraseToAnyPublisher()
        }
        
        override func fetchMealListByCountry(country: String) -> AnyPublisher<MealsResponse, Error> {
            let mealsResponse = MealsResponse(meals: getMealList())
            return Result.Publisher(mealsResponse).eraseToAnyPublisher()
        }
        
        override func fetchCategories() -> AnyPublisher<CategoriesResponse, Error> {
            let categoriesResponse = CategoriesResponse(categories: getCagegory())
            return Result.Publisher(categoriesResponse).eraseToAnyPublisher()
        }
        
        private func getMealList() -> [Meal] {
            return [
                Meal(id: "1", strMealThumb: "url1", strMeal: "name1"),
                Meal(id: "2", strMealThumb: "url2", strMeal: "name2"),
                Meal(id: "3", strMealThumb: "url3", strMeal: "name3"),
                Meal(id: "4", strMealThumb: "url4", strMeal: "name4")
            ]
        }
        
        private func getCagegory() -> [FetchRewards.Category] {
            return [
                FetchRewards.Category(id: "1", strCategory: "Italian"),
                FetchRewards.Category(id: "2", strCategory: "Canadian"),
                FetchRewards.Category(id: "3", strCategory: "Mexican")
            ]
        }
    }

    
    func testFetchMealsByCategory() {
        let expectation = self.expectation(description: "Fetch meals by category")
        
        let viewModel = MealsViewModel(networkService: MockNetworkService(provider: MoyaProvider<MyAPI>()))
        
        viewModel.fetchMeals(searchOption: .category, query: "Test Category")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(viewModel.meals.count, 4)
            XCTAssertEqual(viewModel.meals.first?.id, "1")
            XCTAssertEqual(viewModel.meals.first?.strMealThumb, "url1")
            XCTAssertEqual(viewModel.meals.first?.strMeal, "name1")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }

    func testFetchMealsByName() {
        // Given
        let viewModel = MealsViewModel(networkService: MockNetworkService(provider: MoyaProvider<MyAPI>()))
        
        // When
        viewModel.fetchMeals(searchOption: .name, query: "Test Category")
        
        // Then
        XCTAssertEqual(viewModel.meals.count, 4)
        XCTAssertEqual(viewModel.meals.first?.strMeal, "Meal 1")
    }
    
    func testFetchMealsByIngredient() {
        // Given
        let viewModel = MealsViewModel(networkService: MockNetworkService(provider: MoyaProvider<MyAPI>()))
        
        // When
        viewModel.fetchMeals(searchOption: .ingredient, query: "Test Category")
        
        // Then
        XCTAssertEqual(viewModel.meals.count, 4)
        XCTAssertEqual(viewModel.meals.first?.strMeal, "Meal 1")
    }
    
    func testFetchMealsByCountry() {
        // Given
        let viewModel = MealsViewModel(networkService: MockNetworkService(provider: MoyaProvider<MyAPI>()))
        
        // When
        viewModel.fetchMeals(searchOption: .area, query: "Test Category")
        
        // Then
        XCTAssertEqual(viewModel.meals.count, 4)
        XCTAssertEqual(viewModel.meals.first?.strMeal, "Meal 1")
    }
    
    
    // Similar tests for other search options (name, ingredient, country)...
    
    func testFetchCategories() {
        // Given
        let viewModel = MealsViewModel(networkService: MockNetworkService(provider: MoyaProvider<MyAPI>()))
        
        // When
        viewModel.fetchCategories()
        
        // Then
        XCTAssertEqual(viewModel.categories.count, 3)
        XCTAssertEqual(viewModel.categories.first?.strCategory, "Category 1")
    }
}
