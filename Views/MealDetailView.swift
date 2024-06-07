//
//  MealDetailView.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import SwiftUI

struct MealDetailView: View {
    @ObservedObject var viewModel: MealDetailViewModel
    let mealId: String
    
    init(viewModel: MealDetailViewModel, mealId: String) {
        self.viewModel = viewModel
        self.mealId = mealId
    }
    
    var body: some View {
        VStack {
            if let meal = viewModel.meal {
                Text(meal.strMeal ?? "Unknown Meal")
                    .font(.largeTitle)
                    .padding()
                Text(meal.strInstructions ?? "No instructions available.")
                    .padding()
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            viewModel.fetchMealDetail(byId: mealId)
        }
    }
}
