//
//  MealDetailView.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import SwiftUI
import Kingfisher
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

/**
 The `MealInfoView` struct displays detailed information about a meal, including its name, instructions, and ingredients.
 */
struct MealInfoView: View {
    
    /// The meal details to display.
    let meal: MealDetails
    
    var body: some View {
        VStack(spacing: 20) {
            // Display meal name.
            Text(meal.strMeal ?? String.Localization.unknown_meal)
                .font(.largeTitle)
                .accessibilityLabel(meal.strMeal ?? String.Localization.unknown_meal)
                .foregroundColor(.primary)
            
            // Display the meal image, area, category, and video link.

            
            VStack{
                if let mealThumb = meal.strMealThumb {
                    KFImage(URL(string: mealThumb))
                        .resizable().frame(height: 200)
                        .scaledToFit()
                        .cornerRadius(8)
                        .padding()
                }
                if let strCategory = meal.strCategory{
                    Text("Category: \(strCategory)")
                        .font(.headline)
                }
                if let strArea = meal.strArea{
                    Text("Area: \(strArea)")
                        .font(.headline)
                }
                if let strYoutube = meal.strYoutube, let url = URL(string: strYoutube) {
                    Link("Watch the Video", destination: url)
                        .font(.headline)
                }
            }

            
            Divider()
            
            // Display meal instructions.
            Text(String.Localization.instructions)
                .font(.headline)
                .accessibilityLabel(String.Localization.instructions)
                .foregroundColor(.primary)
            
            Text(meal.strInstructions ?? String.Localization.no_instructions_available)
                .padding()
                .foregroundColor(.primary)
            
            Divider()
            // Display list of ingredients.
            IngredientsListView(meal: meal)

        }
    }
}

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
