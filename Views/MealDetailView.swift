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
            Text("Instructions")
                .font(.headline)
            Text(meal.strInstructions ?? "No instructions available.").padding()
            Divider()
            IngredientsListView(meal: meal)
        }
    }
}

struct IngredientsListView: View {
    let meal: MealDetails

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Ingredients")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 8)
                .foregroundColor(.primary)

            ForEach(meal.getIngredientMeasurementListxx(), id: \.0) { ingredient, measure in
                HStack {
                    Text(ingredient)
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(measure)
                        .font(.body)
                        .foregroundColor(.primary)
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

