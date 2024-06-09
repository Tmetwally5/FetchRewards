//
//  MealsListView.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import SwiftUI

/**
 The `MealsListView` struct represents the main view for browsing meals.
 
 It allows users to search for meals by different criteria such as category, name, or ingredient.
 */
struct MealsListView: View {
    
    /// The view model responsible for managing the list of meals.
    @EnvironmentObject var mealsViewModel: MealsViewModel
    
    /// The view model responsible for managing the meal detail data.
    @EnvironmentObject var detailsViewModel: MealDetailViewModel
    
    /// The network reachability manager.
    @EnvironmentObject var reachability: Reachability
    
    /// The search query entered by the user.
    @State private var searchQuery: String = ""
    
    /// The selected category for meal search.
    @State private var category: String = ""
    
    /// The selected search option (category, name, or ingredient).
    @State private var selectedSearchOption: SearchOption = .category

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                // Display message for no internet connection if applicable.
                if !reachability.isConnected {
                    Spacer()
                    Text(String.Localization.no_internet_connection)
                        .foregroundColor(.red)
                        .padding()
                    Spacer()
                } else {
                    // Display search option picker.
                    SearchOptionPicker(selectedSearchOption: $selectedSearchOption)
                        .onChange(of: selectedSearchOption) { _, newValue in
                            handleSearchOptionChange(newValue)
                        }
                        .padding(.bottom, 10)
                        .accessibilityLabel(String.Localization.search_by)
                    
                    // Display search input field based on the selected search option.
                    if selectedSearchOption == .category {
                        CategoryPickerView(viewModel: mealsViewModel, searchQuery: $searchQuery, category: $category)
                    } else {
                        SearchTextFieldView(
                            selectedSearchOption: selectedSearchOption,
                            searchQuery: $searchQuery,
                            fetchMealsAction: {
                                mealsViewModel.fetchMeals(searchOption: selectedSearchOption, query: searchQuery)
                            }
                        )
                    }
                    
                    // Display list of meals or no results message.
                    if mealsViewModel.meals.isEmpty {
                        NoResultsView(selectedSearchOption: selectedSearchOption)
                    } else {
                        MealsList(viewModel: mealsViewModel, detailsViewModel: detailsViewModel)
                    }
                }
            }
            .padding(.horizontal, 5)
            .onAppear {
                // Fetch meal categories on view appear if connected to the internet.
                if reachability.isConnected {
                    mealsViewModel.fetchCategories()
                }
            }
            .onChange(of: searchQuery) { _, _ in
                // Fetch meals when the search query changes.
                if selectedSearchOption != .area && selectedSearchOption != .ingredient {
                    mealsViewModel.fetchMeals(searchOption: selectedSearchOption, query: searchQuery)
                }
            }
            .onChange(of: reachability.isConnected) { _, isConnected in
                // Fetch meal categories and meals when internet connection status changes.
                if isConnected {
                    mealsViewModel.fetchCategories()
                    mealsViewModel.fetchMeals(searchOption: selectedSearchOption, query: searchQuery)
                }
            }
            .navigationBarTitle(String.Localization.recipes)
            .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize))
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Enable navigation on iPad
    }

    /**
     Handles the change in the selected search option.
     
     - Parameter newValue: The new selected search option.
     */
    private func handleSearchOptionChange(_ newValue: SearchOption) {
        // Reset meals list and update search query based on the selected option.
        mealsViewModel.meals = []
        if newValue == .name {
            searchQuery = ""
            mealsViewModel.fetchMeals(searchOption: newValue, query: searchQuery)
        } else if newValue == .category {
            searchQuery = category
            mealsViewModel.fetchMeals(searchOption: newValue, query: searchQuery)
        } else {
            searchQuery = ""
        }
    }
}
