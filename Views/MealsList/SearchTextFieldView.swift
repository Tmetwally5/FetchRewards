//
//  MealsListView.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import SwiftUI
/**
 The `SearchTextFieldView` struct represents a view containing a text field for entering search queries based on the selected search option.
 
 It includes a text field for entering search queries and a button to trigger the search action. The appearance and behavior of the view depend on the selected search option.
 */
struct SearchTextFieldView: View {
    
    /// The selected search option.
    var selectedSearchOption: SearchOption
    
    /// Binding to the search query entered by the user.
    @Binding var searchQuery: String
    
    /// Action to be performed when the user initiates a search.
    var fetchMealsAction: () -> Void

    var body: some View {
        HStack {
            // Display a text field for entering search queries.
            TextField(selectedSearchOption.getAsExample(), text: $searchQuery)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .accessibilityLabel(selectedSearchOption.getAsExample())
                .accessibilityValue(searchQuery)
                .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize))
            
            // Display a search button to trigger the search action.
            if selectedSearchOption != .name {
                Button(action: fetchMealsAction) {
                    Text(String.Localization.search)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 100, height: 40)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .accessibilityLabel(String.Localization.search)
                        .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                }
            }
        }
    }
}
