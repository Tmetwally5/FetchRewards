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
                .accessibilityElement(children: .ignore)
        }
        .onAppear {
            viewModel.fetchMealDetail(byId: mealId)
        }
        .accessibilityElement(children: .contain)
    }
    
    @ViewBuilder
    private var contentView: some View {
        if let meal = viewModel.meal {
            ScrollView {
                MealInfoView(meal: meal)
            }
        } else {
            Text(String.Localization.loading)
                .accessibilityLabel(String.Localization.loading)
        }
    }
}

struct MealInfoView: View {
    let meal: MealDetails
    
    var body: some View {
        VStack(spacing: 20) {
            Text(meal.strMeal ?? String.Localization.unknown_meal)
                .font(.largeTitle)
                .accessibilityLabel(meal.strMeal ?? String.Localization.unknown_meal)
                .foregroundColor(.primary) 
            
            Divider()
            
            Text(String.Localization.instructions)
                .font(.headline)
                .accessibilityLabel(String.Localization.instructions)
                .foregroundColor(.primary)
            
            Text(meal.strInstructions ?? String.Localization.no_instructions_available)
                .padding()
                .foregroundColor(.primary)
            
            Divider()
            
            IngredientsListView(meal: meal)
        }
    }
}

struct IngredientsListView: View {
    let meal: MealDetails

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(String.Localization.ingredients)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 8)
                .foregroundColor(.primary)
                .accessibilityLabel(String.Localization.ingredients)

            ForEach(meal.getIngredientMeasurementListxx(), id: \.0) { ingredient, measure in
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
