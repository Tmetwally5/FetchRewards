//
//  MealsListView.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import SwiftUI

struct MealsListView: View {
    @ObservedObject var viewModel: MealsViewModel
    @ObservedObject var detailsViewModel: MealDetailViewModel
    @State private var searchQuery: String = ""
    @State private var selectedSearchOption: SearchOption = .category
    
    init(networkService: NetworkService) {
        self.viewModel = MealsViewModel(networkService: networkService)
        self.detailsViewModel = MealDetailViewModel(networkService: networkService)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Search By", selection: $selectedSearchOption) {
                    ForEach(SearchOption.allCases, id: \.self) { option in
                        Text(option.rawValue.capitalized)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                TextField("Enter \(selectedSearchOption.rawValue.capitalized)", text: $searchQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    viewModel.fetchMeals(category: searchQuery)
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
                    NavigationLink(destination: MealDetailView(viewModel: detailsViewModel, mealId: meal.id ?? "")) {
                        Text(meal.strMeal ?? "")
                    }
                }
            }
            .padding()
            .navigationTitle("Recipes")
        }
    }
}

enum SearchOption: String, CaseIterable {
    case category
    case area
    case ingredient
    case name
}

struct MealsListView_Previews: PreviewProvider {
    static var previews: some View {
        MealsListView(networkService: NetworkService())
    }
}