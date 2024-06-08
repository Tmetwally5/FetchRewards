//
//  extension + String.swift
//  FetchRewards
//
//  Created by Taha Metwally on 7/6/2024.
//

import Foundation

extension String {
    struct Localization {
        static var no_internet_connection: String {
            NSLocalizedString("no_internet_connection", comment: "")
        }

        static var recipes: String {
            NSLocalizedString("recipes", comment: "")
        }

        static var search_by: String {
            NSLocalizedString("search_by", comment: "")
        }

        static var select_search_option: String {
            NSLocalizedString("select_search_option", comment: "")
        }

        static var select_a_category: String {
            NSLocalizedString("select_a_category", comment: "")
        }

        static var select_category: String {
            NSLocalizedString("select_category", comment: "")
        }

        static var search: String {
            NSLocalizedString("search", comment: "")
        }

        static func no_results(_ option: String) -> String {
            String(format: NSLocalizedString("no_results", comment: ""), option)
        }

        static var area_example: String {
            NSLocalizedString("area_example", comment: "")
        }

        static var category_example: String {
            NSLocalizedString("category_example", comment: "")
        }

        static var ingredient_example: String {
            NSLocalizedString("ingredient_example", comment: "")
        }

        static var name_example: String {
            NSLocalizedString("name_example", comment: "")
        }
        static var no_instructions_available: String {
            NSLocalizedString("no_instructions_available", comment: "")
        }
        static var unknown_meal: String {
            NSLocalizedString("unknown_meal", comment: "")
        }
        static var ingredients: String {
            NSLocalizedString("Ingredients", comment: "")
        }
        static var instructions: String {
            NSLocalizedString("Instructions", comment: "")
        }
        static var loading: String {
            NSLocalizedString("Loading...", comment: "")
        }
    }
}
