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
    
    var body: some View {
        VStack {
            contentView
        }
        .onAppear {
            viewModel.fetchMealDetail(byId: mealId)
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        if let meal = viewModel.meal {
            ScrollView{
                MealInfoView(meal: meal)
            }
        } else {
            Text("Loading...")
        }
    }
}

struct MealInfoView: View {
    let meal: MealDetails
    
    var body: some View {
        VStack(spacing: 20) {
            Text(meal.strMeal ?? "Unknown Meal")
                .font(.largeTitle)
            
            Divider()
            Text("Instructions:")
                .font(.headline)
            
            Text(meal.strInstructions ?? "No instructions available.")
            Divider()
            
            IngredientsListView(meal: meal)
        }
        .padding()
    }
}

struct IngredientsListView: View {
    let meal: MealDetails
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Ingredients:")
                .font(.headline)
            
            ForEach(meal.getIngredientMeasurementListxx(), id: \.0) { ingredient, measure in
                    Text("\(ingredient) - \(measure)")
            }
        }
    }
}

extension MealDetails {
    func value(for key: String) -> String {
        return ""
    }
}
