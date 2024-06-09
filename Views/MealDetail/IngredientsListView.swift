//
//  MealDetailView.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import SwiftUI
/**
 The `IngredientsListView` struct displays a list of ingredients and their measurements for a meal.
 */
struct IngredientsListView: View {
    
    /// The meal details containing the ingredients to display.
    let meal: MealDetails

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Display section header for ingredients.
            Text(String.Localization.ingredients)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 8)
                .foregroundColor(.primary)
                .accessibilityLabel(String.Localization.ingredients)

            ForEach(meal.getIngredientMeasurementList(), id: \.0) { ingredient, measure in
                // Display each ingredient and its measurement.
                HStack {
                    Text(ingredient)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .accessibilityLabel(ingredient)
                    
                    Spacer()
                    
                    Text(measure)
                        .font(.body)
                        .foregroundColor(.primary)
                        .accessibilityLabel(measure)
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 5)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
        .padding()
    }
}
