//
//  extension + String.swift
//  FetchRewards
//
//  Created by Taha Metwally on 7/6/2024.
//

import Foundation

extension String {
    class Localization {
        class var no_internet_connection: String {
            return NSLocalizedString("no_internet_connection", comment: "")
        }

        class var recipes: String {
            return NSLocalizedString("recipes", comment: "")
        }

        class var search_by: String {
            return NSLocalizedString("search_by", comment: "")
        }

        class var select_search_option: String {
            return NSLocalizedString("select_search_option", comment: "")
        }

        class var select_a_category: String {
            return NSLocalizedString("select_a_category", comment: "")
        }

        class var select_category: String {
            return NSLocalizedString("select_category", comment: "")
        }

        class var search: String {
            return NSLocalizedString("search", comment: "")
        }

        class func no_results(_ option: String) -> String {
            return String(format: NSLocalizedString("no_results", comment: ""), option)
        }

        // SearchOption examples
        class var area_example: String {
            return NSLocalizedString("area_example", comment: "")
        }

        class var category_example: String {
            return NSLocalizedString("category_example", comment: "")
        }

        class var ingredient_example: String {
            return NSLocalizedString("ingredient_example", comment: "")
        }

        class var name_example: String {
            return NSLocalizedString("name_example", comment: "")
        }
    }
}
