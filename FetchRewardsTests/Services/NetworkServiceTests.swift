//
//  NetworkServiceTests.swift
//  FetchRewardsTests
//
//  Created by Taha Metwally on 8/6/2024.
//

import XCTest
import Combine
import Moya
@testable import FetchRewards

class NetworkServiceTests: XCTestCase {

    var networkService: NetworkService!
    var mockProvider: MoyaProvider<MyAPI>!
    
    override func setUp() {
        super.setUp()
        // Create a mock provider for testing
        mockProvider = MoyaProvider<MyAPI>()
        // Initialize the network service with the mock provider
        networkService = NetworkService(provider: mockProvider)
        
    }

    override func tearDown() {
        networkService = nil
        mockProvider = nil
        super.tearDown()
    }
    
    // Test fetching meal list by category
    func testFetchMealListByCategory() {
        // Given
        let category = "Chicken"
        
        // When
        let publisher = networkService.fetchMealListByCategory(category: category)
        
        // Then
        let expectation = XCTestExpectation(description: "Fetch meals by category")
        var mealsResponse: MealsResponse?
        var error: Error?
        
        let cancellable = publisher
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let err):
                    error = err
                    expectation.fulfill()
                }
            }, receiveValue: { response in
                mealsResponse = response
            })
        
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(mealsResponse)
        XCTAssertNil(error)
        cancellable.cancel()
    }
    
    // Test fetching meal details by ID
    func testFetchMealDetailsByID() {
        // Given
        let mealID = "52959"
        
        // When
        let publisher = networkService.fetchMealDetailsByID(mealID: mealID)
        
        // Then
        let expectation = XCTestExpectation(description: "Fetch meal details by ID")
        var detailsResponse: MealDetailsResponse?
        var error: Error?
        
        let cancellable = publisher
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let err):
                    error = err
                    expectation.fulfill()
                }
            }, receiveValue: { response in
                detailsResponse = response
            })
        
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(detailsResponse)
        XCTAssertNil(error)
        cancellable.cancel()
    }
    
    func testFetchMealListByName() {
        // Given
        let name = "Pizza"
        
        // When
        let publisher = networkService.fetchMealListByName(name: name)
        
        // Then
        let expectation = self.expectation(description: "Fetch Meal List By Name")
        var mealsResponse: MealsResponse?
        var error: Error?
        
        let cancellable = publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let receivedError):
                error = receivedError
                expectation.fulfill()
            }
        }, receiveValue: { response in
            mealsResponse = response
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        cancellable.cancel()
        
        XCTAssertNotNil(mealsResponse)
        XCTAssertNil(error)
    }
    func testFetchMealListByIngredient() {
        // Given
        let ingredient = "Tomato"
        
        // When
        let publisher = networkService.fetchMealListByIngredient(ingredient: ingredient)
        
        // Then
        let expectation = self.expectation(description: "Fetch Meal List By Ingredient")
        var mealsResponse: MealsResponse?
        var error: Error?
        
        let cancellable = publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let receivedError):
                error = receivedError
                expectation.fulfill()
            }
        }, receiveValue: { response in
            mealsResponse = response
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        cancellable.cancel()
        
        XCTAssertNotNil(mealsResponse)
        XCTAssertNil(error)
    }
    
    func testFetchMealListByCountry() {
        // Given
        let country = "Canadian"
        
        // When
        let publisher = networkService.fetchMealListByCountry(country: country)
        
        // Then
        let expectation = self.expectation(description: "Fetch Meal List By Country")
        var mealsResponse: MealsResponse?
        var error: Error?
        
        let cancellable = publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let receivedError):
                error = receivedError
                expectation.fulfill()
            }
        }, receiveValue: { response in
            mealsResponse = response
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        cancellable.cancel()
        
        XCTAssertNotNil(mealsResponse)
        XCTAssertNil(error)
    }
    
    func testFetchCategories() {
        // When
        let publisher = networkService.fetchCategories()
        
        // Then
        let expectation = self.expectation(description: "Fetch Categories")
        var categoriesResponse: CategoriesResponse?
        var error: Error?
        
        let cancellable = publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let receivedError):
                error = receivedError
                expectation.fulfill()
            }
        }, receiveValue: { response in
            categoriesResponse = response
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        cancellable.cancel()
        
        XCTAssertNotNil(categoriesResponse)
        XCTAssertNil(error)
    }
}

