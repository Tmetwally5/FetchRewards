//
//  MealsListView.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import SwiftUI

/**
 The `SearchOptionPicker` struct represents a view for selecting search options.
 
 It displays a segmented picker control allowing users to choose between different search options such as category, name, or ingredient.
 */
struct SearchOptionPicker: View {
    /// Binding to the selected search option.
    @Binding var selectedSearchOption: SearchOption

    var body: some View {
        VStack {
            // Display label indicating the purpose of the picker.
            Text(String.Localization.search_by)
                .accessibilityLabel(String.Localization.search_by)
                .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize))
            
            // Display segmented picker for selecting search option.
            Picker(String.Localization.select_search_option, selection: $selectedSearchOption) {
                ForEach(SearchOption.allCases, id: \.self) { option in
                    Text(option.rawValue.capitalized)
                        .accessibilityLabel(option.rawValue.capitalized)
                        .tag(option.rawValue.capitalized)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}


/**
 The `SearchOption` enum represents different options for searching meals.
 
 Each case of the enum corresponds to a different search option:
 - `category`: Search by meal category.
 - `name`: Search by meal name.
 - `ingredient`: Search by ingredient.
 - `area`: Search by meal area.
 */
enum SearchOption: String, CaseIterable {
    
    case category
    case name
    case ingredient
    case area
    /**
     Returns an example search query related to the search option.
     
     - Returns: A string representing an example search query for the specific search option.
     */
    func getAsExample() -> String {
        switch self {
        case .area:
            return String.Localization.area_example
        case .category:
            return String.Localization.category_example
        case .ingredient:
            return String.Localization.ingredient_example
        case .name:
            return String.Localization.name_example
        }
    }
}
