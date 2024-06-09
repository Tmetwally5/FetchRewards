//
//  MealsListView.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import SwiftUI
import Kingfisher // Import Kingfisher for image loading
/**
 The `MealsList` struct represents a list view displaying a list of meals.
 
 It presents a list of meals fetched from the `MealsViewModel`. Each meal is displayed as a navigation link to the corresponding meal detail view (`MealDetailView`). The appearance and content of the list are determined by the data provided by the view model.
 */
struct MealsList: View {
    
    /// The view model responsible for managing meal-related data.
    @ObservedObject var viewModel: MealsViewModel
    
    /// The view model responsible for managing meal detail-related data.
    @ObservedObject var detailsViewModel: MealDetailViewModel

    var body: some View {
        // Display a list of meals fetched from the view model.
        List(viewModel.meals) { meal in
            // Each meal is presented as a navigation link to the meal detail view.
            NavigationLink(destination: MealDetailView(viewModel: detailsViewModel, mealId: meal.id ?? "")) {
                // Display the meal's name and image as the content of the navigation link.
                HStack {
                    // Load the meal's image using Kingfisher and display it as a circle.
                    KFImage(URL(string: meal.strMealThumb ?? ""))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .padding(.trailing, 10) // Add some padding between the image and text
                    
                    // Display the meal's name as the text of the navigation link.
                    Text(meal.strMeal ?? "")
                        .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                }
                .accessibilityElement(children: .combine) // Combine accessibility elements for better accessibility
                .accessibilityLabel(meal.strMeal ?? "") // Set accessibility label for the navigation link
            }
        }
        .cornerRadius(8) // Apply corner radius to the list.
    }
}
