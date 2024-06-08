//
//  CategoriesResponse.swift
//  FetchRewards
//
//  Created by Taha Metwally on 7/6/2024.
//

import Foundation

/**
 A structure representing a single category.
 
 This structure conforms to the `Identifiable` and `Codable` protocols. The `Identifiable` conformance allows it to be used easily in SwiftUI lists, while `Codable` allows for easy encoding and decoding from JSON.
 */
struct Category: Identifiable, Codable {
    /// The unique identifier for the category.
    let id: String?
    
    /// The name of the category.
    let strCategory: String?
    
    /// Coding keys to map JSON keys to properties.
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case strCategory
    }
}

/**
 A structure representing the response from the categories API.
 
 This structure conforms to the `Codable` protocol, making it easy to encode and decode from JSON.
 */
struct CategoriesResponse: Codable {
    /// An array of `Category` objects representing the categories fetched from the API.
    let categories: [Category]
}
