//
//  CategoriesResponseTests.swift
//  FetchRewardsTests
//
//  Created by Taha Metwally on 8/6/2024.
//

import XCTest
@testable import FetchRewards

class CategoriesResponseTests: XCTestCase {
    
    func testDecodeCategoriesResponse() throws {
        // Given
        let json = """
        {
            "categories": [
                {
                    "idCategory": "1",
                    "strCategory": "Italian"
                },
                {
                    "idCategory": "2",
                    "strCategory": "Mexican"
                }
            ]
        }
        """.data(using: .utf8)!
        
        // When
        let categoriesResponse = try JSONDecoder().decode(CategoriesResponse.self, from: json)
        
        // Then
        XCTAssertEqual(categoriesResponse.categories.count, 2)
        XCTAssertEqual(categoriesResponse.categories[0].id, "1")
        XCTAssertEqual(categoriesResponse.categories[0].strCategory, "Italian")
        XCTAssertEqual(categoriesResponse.categories[1].id, "2")
        XCTAssertEqual(categoriesResponse.categories[1].strCategory, "Mexican")
        // Add more assertions for other properties
    }
    
}

class CategoryTests: XCTestCase {
    
    func testCategoryInitialization() {
        // Given
        let category = Category(id: "1", strCategory: "Italian")
        
        // Then
        XCTAssertEqual(category.id, "1")
        XCTAssertEqual(category.strCategory, "Italian")
    }
    
}

