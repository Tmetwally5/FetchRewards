//
//  MealsListView.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import SwiftUI

/**
 The `CategoryPickerView` struct represents a view for selecting a category from a list of categories.
 
 It displays a picker control containing available categories fetched from the view model. Users can select a category from the list to filter meals accordingly.
 */
struct CategoryPickerView: View {
    
    /// View model responsible for managing meals data and categories.
    @ObservedObject var viewModel: MealsViewModel
    
    /// Binding to the search query entered by the user.
    @Binding var searchQuery: String
    
    /// Binding to the selected category.
    @Binding var category: String

    var body: some View {
        if !viewModel.categories.isEmpty {
            HStack {
                Spacer()
                // Display label indicating the purpose of the picker.
                Text(String.Localization.select_a_category)
                    .accessibilityLabel(String.Localization.select_a_category)
                    .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                Spacer()
                
                // Display picker control containing available categories.
                if !searchQuery.isEmpty {
                    Picker(String.Localization.select_category, selection: $searchQuery) {
                        ForEach(viewModel.categories, id: \.id) { category in
                            Text(category.strCategory ?? "")
                                .accessibilityLabel(category.strCategory ?? "")
                                .tag(category.strCategory ?? "")
                        }
                    }
                    .pickerStyle(DefaultPickerStyle())
                    .background(Color.blue)
                    .cornerRadius(8)
                    .tint(.white)
                }
                Spacer()
            }
            .cornerRadius(8)
            .onReceive(viewModel.$categories) { _ in
                // Auto-select the first category when categories are loaded and search query is empty.
                if !viewModel.categories.isEmpty && searchQuery.isEmpty {
                    searchQuery = viewModel.categories.first?.strCategory ?? ""
                }
            }
            .onChange(of: searchQuery) { _, newValue in
                category = newValue
            }
            .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize))
           
        } else {
            // Display progress view while fetching categories.
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize))
        }
    }
}
