import XCTest
import Moya
@testable import FetchRewards

class MyAPITests: XCTestCase {

    func testFetchMealDetailsByID() {
        let mealID = "123"
        let expectedBaseURL = URL(string: "https://www.themealdb.com/api/json/v1/1/")!
        
        let apiCase = MyAPI.fetchMealDetailsByID(mealID: mealID)
        
        XCTAssertEqual(apiCase.baseURL, expectedBaseURL)
        XCTAssertEqual(apiCase.path, "lookup.php")
        XCTAssertEqual(apiCase.method, .get)
        XCTAssertEqual(apiCase.headers, ["Content-Type": "application/json"])
        XCTAssertEqual(apiCase.sampleData, Data())
    }
    
    func testFetchMealListByCategory() {
        let category = "Chicken"
        let expectedBaseURL = URL(string: "https://www.themealdb.com/api/json/v1/1/")!
        
        let apiCase = MyAPI.fetchMealListByCategory(category: category)
        
        XCTAssertEqual(apiCase.baseURL, expectedBaseURL)
        XCTAssertEqual(apiCase.path, "filter.php")
        XCTAssertEqual(apiCase.method, .get)
        XCTAssertEqual(apiCase.headers, ["Content-Type": "application/json"])
        XCTAssertEqual(apiCase.sampleData, Data())
    }
    
    func testFetchMealListByName() {
        let name = "Pizza"
        let expectedBaseURL = URL(string: "https://www.themealdb.com/api/json/v1/1/")!
        
        let apiCase = MyAPI.fetchMealListByName(name: name)
        
        XCTAssertEqual(apiCase.baseURL, expectedBaseURL)
        XCTAssertEqual(apiCase.path, "search.php")
        XCTAssertEqual(apiCase.method, .get)
        XCTAssertEqual(apiCase.headers, ["Content-Type": "application/json"])
        XCTAssertEqual(apiCase.sampleData, Data())
    }
    
    func testFetchMealListByIngredient() {
        let ingredient = "Tomato"
        let expectedBaseURL = URL(string: "https://www.themealdb.com/api/json/v1/1/")!
        
        let apiCase = MyAPI.fetchMealListByIngredient(ingredient: ingredient)
        
        XCTAssertEqual(apiCase.baseURL, expectedBaseURL)
        XCTAssertEqual(apiCase.path, "filter.php")
        XCTAssertEqual(apiCase.method, .get)
        XCTAssertEqual(apiCase.headers, ["Content-Type": "application/json"])
        XCTAssertEqual(apiCase.sampleData, Data())
    }
    
    func testFetchMealListByCountry() {
        let country = "Italy"
        let expectedBaseURL = URL(string: "https://www.themealdb.com/api/json/v1/1/")!
        
        let apiCase = MyAPI.fetchMealListByCountry(country: country)
        
        XCTAssertEqual(apiCase.baseURL, expectedBaseURL)
        XCTAssertEqual(apiCase.path, "filter.php")
        XCTAssertEqual(apiCase.method, .get)
        XCTAssertEqual(apiCase.headers, ["Content-Type": "application/json"])
        XCTAssertEqual(apiCase.sampleData, Data())
    }
    
    func testFetchCategories() {
        let expectedBaseURL = URL(string: "https://www.themealdb.com/api/json/v1/1/")!
        
        let apiCase = MyAPI.fetchCategories
        
        XCTAssertEqual(apiCase.baseURL, expectedBaseURL)
        XCTAssertEqual(apiCase.path, "categories.php")
        XCTAssertEqual(apiCase.method, .get)
        XCTAssertEqual(apiCase.headers, ["Content-Type": "application/json"])
        XCTAssertEqual(apiCase.sampleData, Data())
    }
}
