//
//  StringLocalizationTests.swift
//  FetchRewardsTests
//
//  Created by Taha Metwally on 8/6/2024.
//

import XCTest
@testable import FetchRewards

class StringLocalizationTests: XCTestCase {

    func testNoInternetConnection() {
        let localizedString = String.Localization.no_internet_connection
        XCTAssertEqual(localizedString, NSLocalizedString("no_internet_connection", comment: ""))
    }
    
    func testRecipes() {
        let localizedString = String.Localization.recipes
        XCTAssertEqual(localizedString, NSLocalizedString("recipes", comment: ""))
    }
    
    func testSearchBy() {
        let localizedString = String.Localization.search_by
        XCTAssertEqual(localizedString, NSLocalizedString("search_by", comment: ""))
    }
    
    func testSelectSearchOption() {
        let localizedString = String.Localization.select_search_option
        XCTAssertEqual(localizedString, NSLocalizedString("select_search_option", comment: ""))
    }
    
    func testSelectACategory() {
        let localizedString = String.Localization.select_a_category
        XCTAssertEqual(localizedString, NSLocalizedString("select_a_category", comment: ""))
    }
    
    func testSelectCategory() {
        let localizedString = String.Localization.select_category
        XCTAssertEqual(localizedString, NSLocalizedString("select_category", comment: ""))
    }
    
    func testSearch() {
        let localizedString = String.Localization.search
        XCTAssertEqual(localizedString, NSLocalizedString("search", comment: ""))
    }
    
    func testNoResults() {
        let searchOption = "Pizza"
        let localizedString = String.Localization.no_results(searchOption)
        let expectedString = String(format: NSLocalizedString("no_results", comment: ""), searchOption)
        XCTAssertEqual(localizedString, expectedString)
    }
    
    func testAreaExample() {
        let localizedString = String.Localization.area_example
        XCTAssertEqual(localizedString, NSLocalizedString("area_example", comment: ""))
    }
    
    func testCategoryExample() {
        let localizedString = String.Localization.category_example
        XCTAssertEqual(localizedString, NSLocalizedString("category_example", comment: ""))
    }
    
    func testIngredientExample() {
        let localizedString = String.Localization.ingredient_example
        XCTAssertEqual(localizedString, NSLocalizedString("ingredient_example", comment: ""))
    }
    
    func testNameExample() {
        let localizedString = String.Localization.name_example
        XCTAssertEqual(localizedString, NSLocalizedString("name_example", comment: ""))
    }
    
    func testNoInstructionsAvailable() {
        let localizedString = String.Localization.no_instructions_available
        XCTAssertEqual(localizedString, NSLocalizedString("no_instructions_available", comment: ""))
    }
    
    func testUnknownMeal() {
        let localizedString = String.Localization.unknown_meal
        XCTAssertEqual(localizedString, NSLocalizedString("unknown_meal", comment: ""))
    }
    
    func testIngredients() {
        let localizedString = String.Localization.ingredients
        XCTAssertEqual(localizedString, NSLocalizedString("Ingredients", comment: ""))
    }
    
    func testInstructions() {
        let localizedString = String.Localization.instructions
        XCTAssertEqual(localizedString, NSLocalizedString("Instructions", comment: ""))
    }
    
    func testLoading() {
        let localizedString = String.Localization.loading
        XCTAssertEqual(localizedString, NSLocalizedString("Loading...", comment: ""))
    }
    
    func testCategory() {
        let localizedString = String.Localization.category
        XCTAssertEqual(localizedString, NSLocalizedString("category", comment: ""))
    }
    
    func testArea() {
        let localizedString = String.Localization.area
        XCTAssertEqual(localizedString, NSLocalizedString("area", comment: ""))
    }
    
    func testWatchVideo() {
        let localizedString = String.Localization.watch_video
        XCTAssertEqual(localizedString, NSLocalizedString("watch_video", comment: ""))
    }
}
