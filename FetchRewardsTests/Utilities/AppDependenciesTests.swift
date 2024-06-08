//
//  AppDependenciesTests.swift
//  FetchRewardsTests
//
//  Created by Taha Metwally on 8/6/2024.
//

import XCTest
@testable import FetchRewards
import Moya
import Network

class AppDependenciesTests: XCTestCase {
    
    // Mock classes
    class MockNetworkService: NetworkService {
        init() {
            super.init(provider: MoyaProvider<MyAPI>(stubClosure: MoyaProvider.immediatelyStub))
        }
    }

    class MockMealDetailViewModel: MealDetailViewModel {
        init() {
            super.init(networkService: MockNetworkService())
        }
    }

    class MockMealsViewModel: MealsViewModel {
        init() {
            super.init(networkService: MockNetworkService())
        }
    }

    class MockReachability: Reachability {
        init() {
            super.init(monitor: NWPathMonitor())
        }
    }

    func testAppDependenciesInitialization() {
        // Given
        let dependencies = AppDependencies()
        
        // Then
        XCTAssertNotNil(dependencies.moyaProvider, "MoyaProvider should not be nil")
        XCTAssertNotNil(dependencies.networkService, "NetworkService should not be nil")
        XCTAssertNotNil(dependencies.mealDetailViewModel, "MealDetailViewModel should not be nil")
        XCTAssertNotNil(dependencies.mealsViewModel, "MealsViewModel should not be nil")
        XCTAssertNotNil(dependencies.monitor, "NWPathMonitor should not be nil")
        XCTAssertNotNil(dependencies.reachability, "Reachability should not be nil")
    }
    
    func testMealDetailViewModelInitialization() {
        // Given
        let dependencies = AppDependencies()
        
        // Then
        XCTAssertTrue(dependencies.mealDetailViewModel is MealDetailViewModel, "mealDetailViewModel should be of type MealDetailViewModel")
    }
    
    func testMealsViewModelInitialization() {
        // Given
        let dependencies = AppDependencies()
        
        // Then
        XCTAssertTrue(dependencies.mealsViewModel is MealsViewModel, "mealsViewModel should be of type MealsViewModel")
    }
    
    func testReachabilityInitialization() {
        // Given
        let dependencies = AppDependencies()
        
        // Then
        XCTAssertTrue(dependencies.reachability is Reachability, "reachability should be of type Reachability")
    }
}
