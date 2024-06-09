//
//  MealDetailView.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import SwiftUI
import Kingfisher

/**
 The `MealInfoView` struct displays detailed information about a meal, including its name, instructions, ingredients, and additional details like category, area, and video link.
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
                if let strCategory = meal.strCategory {
                    Text("\(String.Localization.category) \(strCategory)")
                        .font(.headline)
                }
                if let strArea = meal.strArea {
                    Text("\(String.Localization.area) \(strArea)")
                        .font(.headline)
                }
                if let strYoutube = meal.strYoutube, let url = URL(string: strYoutube) {
                    Link(String.Localization.watch_video, destination: url)
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

