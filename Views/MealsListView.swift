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

/**
 The `SearchOptionPicker` struct represents a view for selecting search options.
 
 It displays a segmented picker control allowing users to choose between different search options such as category, name, or ingredient.
 */
struct SearchOptionPicker: View {
    
    /// Binding to the selected search option.
    @Binding var selectedSearchOption: SearchOption

    var body: some View {
        VStack {
            // Display label indicating the purpose of the picker.
            Text(String.Localization.search_by)
                .accessibilityLabel(String.Localization.search_by)
                .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize))
            
            // Display segmented picker for selecting search option.
            Picker(String.Localization.select_search_option, selection: $selectedSearchOption) {
                ForEach(SearchOption.allCases, id: \.self) { option in
                    Text(option.rawValue.capitalized)
                        .accessibilityLabel(option.rawValue.capitalized)
                        .tag(option.rawValue.capitalized)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}

/**
 The `CategoryPickerView` struct represents a view for selecting a category from a list of categories.
 
 It displays a picker control containing available categories fetched from the view model. Users can select a category from the list to filter meals accordingly.
 */
struct CategoryPickerView: View {
    
    /// View model responsible for managing meals data and categories.
    @ObservedObject var viewModel: MealsViewModel
    
    /// Binding to the search query entered by the user.
    @Binding var searchQuery: String
    
    /// Binding to the selected category.
    @Binding var category: String

    var body: some View {
        if !viewModel.categories.isEmpty {
            HStack {
                Spacer()
                // Display label indicating the purpose of the picker.
                Text(String.Localization.select_a_category)
                    .accessibilityLabel(String.Localization.select_a_category)
                    .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                Spacer()
                
                // Display picker control containing available categories.
                if !searchQuery.isEmpty {
                    Picker(String.Localization.select_category, selection: $searchQuery) {
                        ForEach(viewModel.categories, id: \.id) { category in
                            Text(category.strCategory ?? "")
                                .accessibilityLabel(category.strCategory ?? "")
                                .tag(category.strCategory ?? "")
                        }
                    }
                    .pickerStyle(DefaultPickerStyle())
                    .background(Color.blue)
                    .cornerRadius(8)
                    .tint(.white)
                }
                Spacer()
            }
            .cornerRadius(8)
            .onReceive(viewModel.$categories) { _ in
                // Auto-select the first category when categories are loaded and search query is empty.
                if !viewModel.categories.isEmpty && searchQuery.isEmpty {
                    searchQuery = viewModel.categories.first?.strCategory ?? ""
                }
            }
            .onChange(of: searchQuery) { _, newValue in
                category = newValue
            }
            .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize))
           
        } else {
            // Display progress view while fetching categories.
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize))
        }
    }
}

/**
 The `SearchTextFieldView` struct represents a view containing a text field for entering search queries based on the selected search option.
 
 It includes a text field for entering search queries and a button to trigger the search action. The appearance and behavior of the view depend on the selected search option.
 */
struct SearchTextFieldView: View {
    
    /// The selected search option.
    var selectedSearchOption: SearchOption
    
    /// Binding to the search query entered by the user.
    @Binding var searchQuery: String
    
    /// Action to be performed when the user initiates a search.
    var fetchMealsAction: () -> Void

    var body: some View {
        HStack {
            // Display a text field for entering search queries.
            TextField(selectedSearchOption.getAsExample(), text: $searchQuery)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .accessibilityLabel(selectedSearchOption.getAsExample())
                .accessibilityValue(searchQuery)
                .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize))
            
            // Display a search button to trigger the search action.
            if selectedSearchOption != .name {
                Button(action: fetchMealsAction) {
                    Text(String.Localization.search)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 100, height: 40)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .accessibilityLabel(String.Localization.search)
                        .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                }
            }
        }
    }
}

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
                // Display the meal's name as the text of the navigation link.
                Text(meal.strMeal ?? "")
                    .accessibilityLabel(meal.strMeal ?? "")
                    .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize))
            }
        }
        .cornerRadius(8) // Apply corner radius to the list.
    }
}


/**
 The `NoResultsView` struct represents a view displayed when there are no search results available for the selected search option.
 
 It presents a message indicating that no search results were found based on the selected search option.
 */
struct NoResultsView: View {
    
    /// The selected search option for which no results were found.
    var selectedSearchOption: SearchOption

    var body: some View {
        // Display a message indicating no search results were found for the selected search option.
        Text(String.Localization.no_results(selectedSearchOption.rawValue))
            .foregroundColor(.gray) // Set text color to gray.
            .multilineTextAlignment(.center) // Center-align text.
            .padding() // Add padding around the text.
            .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize)) // Set font size.
        Spacer() // Add spacer to push content to the top.
    }
}

/**
 The `SearchOption` enum represents different options for searching meals.
 
 Each case of the enum corresponds to a different search option:
 - `category`: Search by meal category.
 - `name`: Search by meal name.
 - `ingredient`: Search by ingredient.
 - `area`: Search by meal area.
 */
enum SearchOption: String, CaseIterable {
    
    case category
    case name
    case ingredient
    case area

    /**
     Returns an example search query related to the search option.
     
     - Returns: A string representing an example search query for the specific search option.
     */
    func getAsExample() -> String {
        switch self {
        case .area:
            return String.Localization.area_example
        case .category:
            return String.Localization.category_example
        case .ingredient:
            return String.Localization.ingredient_example
        case .name:
            return String.Localization.name_example
        }
    }
}
