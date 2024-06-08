//
//  extension + String.swift
//  FetchRewards
//
//  Created by Taha Metwally on 7/6/2024.
//

import Foundation

/**
 An extension of the `String` class to provide localized strings for the FetchRewards application. This extension defines a nested `Localization` struct that contains static properties and methods for accessing localized string values.

 - Note: The `NSLocalizedString` function is used to fetch the localized strings from the app's Localizable.strings file.
 */
extension String {
    /**
     A nested struct that contains static properties and methods to fetch localized string values.
     */
    struct Localization {
        
        /// Localized string for "No Internet Connection".
        static var no_internet_connection: String {
            NSLocalizedString("no_internet_connection", comment: "")
        }

        /// Localized string for "Recipes".
        static var recipes: String {
            NSLocalizedString("recipes", comment: "")
        }

        /// Localized string for "Search By".
        static var search_by: String {
            NSLocalizedString("search_by", comment: "")
        }

        /// Localized string for "Select Search Option".
        static var select_search_option: String {
            NSLocalizedString("select_search_option", comment: "")
        }

        /// Localized string for "Select a Category".
        static var select_a_category: String {
            NSLocalizedString("select_a_category", comment: "")
        }

        /// Localized string for "Select Category".
        static var select_category: String {
            NSLocalizedString("select_category", comment: "")
        }

        /// Localized string for "Search".
        static var search: String {
            NSLocalizedString("search", comment: "")
        }

        /**
         Localized string for "We did not find any recipes for this %@. Try searching for something different." with a specific search option.
         
         - Parameter option: The search option to include in the localized string.
         - Returns: A formatted localized string with the given search option.
         */
        static func no_results(_ option: String) -> String {
            String(format: NSLocalizedString("no_results", comment: ""), option)
        }

        /// Localized string for "Area Example".
        static var area_example: String {
            NSLocalizedString("area_example", comment: "")
        }

        /// Localized string for "Category Example".
        static var category_example: String {
            NSLocalizedString("category_example", comment: "")
        }

        /// Localized string for "Ingredient Example".
        static var ingredient_example: String {
            NSLocalizedString("ingredient_example", comment: "")
        }

        /// Localized string for "Name Example".
        static var name_example: String {
            NSLocalizedString("name_example", comment: "")
        }

        /// Localized string for "No Instructions Available".
        static var no_instructions_available: String {
            NSLocalizedString("no_instructions_available", comment: "")
        }

        /// Localized string for "Unknown Meal".
        static var unknown_meal: String {
            NSLocalizedString("unknown_meal", comment: "")
        }

        /// Localized string for "Ingredients".
        static var ingredients: String {
            NSLocalizedString("Ingredients", comment: "")
        }

        /// Localized string for "Instructions".
        static var instructions: String {
            NSLocalizedString("Instructions", comment: "")
        }

        /// Localized string for "Loading...".
        static var loading: String {
            NSLocalizedString("Loading...", comment: "")
        }
        
        /// Localized string for category.
        static var category: String {
            NSLocalizedString("category", comment: "")
        }
        
        /// Localized string for area.
        static var area: String {
            NSLocalizedString("area", comment: "")
        }
        
        /// Localized string for watch video.
        static var watch_video: String {
            NSLocalizedString("watch_video", comment: "")
        }
    }
}
