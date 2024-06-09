//
//  MealsListView.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import SwiftUI

/**
 The `NoResultsView` struct represents a view displayed when there are no search results available for the selected search option.
 
 It presents a message indicating that no search results were found based on the selected search option.
 */
struct NoResultsView: View {
    
    /// The selected search option for which no results were found.
    var selectedSearchOption: SearchOption

    var body: some View {
        // Display a message indicating no search results were found for the selected search option.
        Text(String.Localization.no_results(selectedSearchOption.rawValue))
            .foregroundColor(.gray) // Set text color to gray.
            .multilineTextAlignment(.center) // Center-align text.
            .padding() // Add padding around the text.
            .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize)) // Set font size.
        Spacer() // Add spacer to push content to the top.
    }
}
