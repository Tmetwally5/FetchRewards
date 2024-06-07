//
//  MealsListView.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import SwiftUI

struct MealsListView: View {
    @ObservedObject var viewModel: MealsViewModel
    @State private var searchText: String = ""
    
    init(networkService: NetworkService) {
        self.viewModel = MealsViewModel(networkService: networkService)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter category", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    viewModel.fetchMeals(category: searchText)
                }) {
                    Text("Search")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                List(viewModel.meals) { meal in
                    Text(meal.strMeal ?? "")
                }
            }
            .padding()
            .navigationTitle("Recipes")
        }
    }
}
