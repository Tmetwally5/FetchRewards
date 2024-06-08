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
        
        var shouldFail = false
        
        override func fetchMealListByCategory(category: String) -> AnyPublisher<MealsResponse, Error> {
            if shouldFail {
                return Fail(error: NSError(domain: "MockError", code: 123, userInfo: nil)).eraseToAnyPublisher()
            } else {
                let mealsResponse = MealsResponse(meals: getMealList())
                return Result.Publisher(mealsResponse).eraseToAnyPublisher()
            }
        }
        
        override func fetchMealListByName(name: String) -> AnyPublisher<MealsResponse, Error> {
            if shouldFail {
                return Fail(error: NSError(domain: "MockError", code: 123, userInfo: nil)).eraseToAnyPublisher()
            } else {
                let mealsResponse = MealsResponse(meals: getMealList())
                return Result.Publisher(mealsResponse).eraseToAnyPublisher()
            }
        }
        
        override func fetchMealListByIngredient(ingredient: String) -> AnyPublisher<MealsResponse, Error> {
            if shouldFail {
                return Fail(error: NSError(domain: "MockError", code: 123, userInfo: nil)).eraseToAnyPublisher()
            } else {
                let mealsResponse = MealsResponse(meals: getMealList())
                return Result.Publisher(mealsResponse).eraseToAnyPublisher()
            }
        }
        
        override func fetchMealListByCountry(country: String) -> AnyPublisher<MealsResponse, Error> {
            if shouldFail {
                return Fail(error: NSError(domain: "MockError", code: 123, userInfo: nil)).eraseToAnyPublisher()
            } else {
                let mealsResponse = MealsResponse(meals: getMealList())
                return Result.Publisher(mealsResponse).eraseToAnyPublisher()
            }
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

    
    func testFetchMealsByCategorySuccess() {
        testFetchMeals(searchOption: .category, query: "Test Category",shouldFail: false)
    }
    
    func testFetchMealsByCategoryFailure() {
        testFetchMeals(searchOption: .category, query: "Test Category", shouldFail: true)
    }

    func testFetchMealsByNameSuccess() {
        testFetchMeals(searchOption: .name, query: "Test Category",shouldFail: false)
    }
    
    func testFetchMealsByNameFailure() {
        testFetchMeals(searchOption: .name, query: "Test Category",shouldFail: true)
    }
    

    func testFetchMealsByIngredientSuccess() {
        testFetchMeals(searchOption: .ingredient, query: "Test Category",shouldFail: false)
    }
    
    func testFetchMealsByIngredientFailure() {
        testFetchMeals(searchOption: .ingredient, query: "Test Category",shouldFail: true)
    }

    func testFetchMealsByCountrySuccess() {
        testFetchMeals(searchOption: .area, query: "Test Category",shouldFail: false)
    }
    
    func testFetchMealsByCountryFailure() {
        testFetchMeals(searchOption: .area, query: "Test Category",shouldFail: true)
    }
    
    private func testFetchMeals(searchOption: SearchOption, query: String, shouldFail: Bool) {
         let expectation = self.expectation(description: "Fetch meals")
         
         let viewModel = MealsViewModel(networkService: MockNetworkService(provider: MoyaProvider<MyAPI>()))
         (viewModel.networkService as? MockNetworkService)?.shouldFail = shouldFail
         
         viewModel.fetchMeals(searchOption: searchOption, query: query)
         
         DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
             if shouldFail {
                 XCTAssert(viewModel.meals.isEmpty)
             } else {
                 XCTAssertEqual(viewModel.meals.count, 4)
                 XCTAssertEqual(viewModel.meals.first?.id, "1")
                 XCTAssertEqual(viewModel.meals.first?.strMealThumb, "url1")
                 XCTAssertEqual(viewModel.meals.first?.strMeal, "name1")
             }
             
             expectation.fulfill()
         }
         
         waitForExpectations(timeout: 2.0, handler: nil)
     }
    
    func testFetchCategories() {
       
        let expectation = self.expectation(description: "Fetch the meal's categories")
        
        let viewModel = MealsViewModel(networkService: MockNetworkService(provider: MoyaProvider<MyAPI>()))

        viewModel.fetchCategories()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(viewModel.categories.count, 3)
            XCTAssertEqual(viewModel.categories.first?.id, "1")
            XCTAssertEqual(viewModel.categories.first?.strCategory, "Italian")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
    }
}
