//
//  MealDetailView.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import SwiftUI

/**
 The `MealDetailView` struct represents the detail view of a meal, displaying information such as meal name, instructions, and ingredients.
 
 It fetches the meal detail upon appearance and dynamically updates the view when the meal data is available.
 */
struct MealDetailView: View {
    
    /// The view model responsible for managing the meal detail data.
    @ObservedObject var viewModel: MealDetailViewModel
    
    /// The ID of the meal to fetch and display details for.
    let mealId: String
    
    var body: some View {
        VStack {
            contentView
                .accessibilityElement(children: .ignore)
        }
        .onAppear {
            // Fetch the meal detail data when the view appears.
            viewModel.fetchMealDetail(byId: mealId)
        }
        .accessibilityElement(children: .contain)
    }
    
    /// The main content view of the meal detail screen.
    @ViewBuilder
    private var contentView: some View {
        if let meal = viewModel.meal {
            // Display meal information if available.
            ScrollView {
                MealInfoView(meal: meal)
            }
        } else {
            // Display a loading indicator if meal information is being fetched.
            Text(String.Localization.loading)
                .accessibilityLabel(String.Localization.loading)
        }
    }
}
