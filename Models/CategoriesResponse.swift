//
//  CategoriesResponse.swift
//  FetchRewards
//
//  Created by Taha Metwally on 7/6/2024.
//

import Foundation

// MARK: - Category
struct Category: Identifiable, Codable {
    let id: String?
    let strCategory: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case strCategory
    }
}

// MARK: - CategoriesResponse
struct CategoriesResponse: Codable {
    let categories: [Category]
}
