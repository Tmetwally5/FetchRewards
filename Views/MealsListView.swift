//
//  MealsListView.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import SwiftUI

struct MealsListView: View {
    @ObservedObject var viewModel: MealsViewModel
    @State var category:String = "Dessert"
    init(networkService: NetworkService) {
        self.viewModel = MealsViewModel(networkService: networkService)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                List(viewModel.meals) { meal in
                    Text(meal.strMeal ?? "")
                }
                //.navigationTitle("\(viewModel.category) Recipes")
            }
            .onAppear {
                viewModel.fetchMeals(category: category)
            }
        }
    }
}
