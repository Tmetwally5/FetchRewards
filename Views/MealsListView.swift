//
//  MealsListView.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//
//
import SwiftUI


struct MealsListView: View {
    @EnvironmentObject var mealsViewModel: MealsViewModel
    @EnvironmentObject var detailsViewModel: MealDetailViewModel
    @EnvironmentObject var reachability: Reachability
    @State private var searchQuery: String = ""
    @State private var category: String = ""
    @State private var selectedSearchOption: SearchOption = .category

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                if !reachability.isConnected {
                    Spacer()
                    Text(String.Localization.no_internet_connection)
                        .foregroundColor(.red)
                        .padding()
                    Spacer()
                } else {
                    SearchOptionPicker(selectedSearchOption: $selectedSearchOption)
                        .onChange(of: selectedSearchOption) { _, newValue in
                            handleSearchOptionChange(newValue)
                        }
                        .padding(.bottom, 10)
                        .accessibilityLabel(String.Localization.search_by)
                    
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
                    if mealsViewModel.meals.isEmpty {
                        NoResultsView(selectedSearchOption: selectedSearchOption)
                    } else {
                        MealsList(viewModel: mealsViewModel, detailsViewModel: detailsViewModel)
                    }
                }
            }
            .padding(.horizontal, 5)
            .onAppear {
                if reachability.isConnected {
                    mealsViewModel.fetchCategories()
                }
            }
            .onChange(of: searchQuery) { _, _ in
                if selectedSearchOption != .area && selectedSearchOption != .ingredient {
                    mealsViewModel.fetchMeals(searchOption: selectedSearchOption, query: searchQuery)
                }
            }
            .onChange(of: reachability.isConnected) { _, isConnected in
                if isConnected {
                    mealsViewModel.fetchCategories()
                    mealsViewModel.fetchMeals(searchOption: selectedSearchOption, query: searchQuery)
                }
            }
            .navigationBarTitle(String.Localization.recipes)
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Enable navigation on iPad
    }

    private func handleSearchOptionChange(_ newValue: SearchOption) {
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

struct SearchOptionPicker: View {
    @Binding var selectedSearchOption: SearchOption

    var body: some View {
        VStack {
            Text(String.Localization.search_by)
                .accessibilityLabel(String.Localization.search_by)
                .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize))
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





struct CategoryPickerView: View {
    @ObservedObject var viewModel: MealsViewModel
    @Binding var searchQuery: String
    @Binding var category: String

    var body: some View {
        if !viewModel.categories.isEmpty {
            HStack {
                Spacer()
                Text(String.Localization.select_a_category)
                    .accessibilityLabel(String.Localization.select_a_category)
                    .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                Spacer()
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
                if !viewModel.categories.isEmpty && searchQuery.isEmpty {
                    searchQuery = viewModel.categories.first?.strCategory ?? ""
                }
            }
            .onChange(of: searchQuery) { _, newValue in
                category = newValue
            }
        } else {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize))
        }
    }
}

struct SearchTextFieldView: View {
    var selectedSearchOption: SearchOption
    @Binding var searchQuery: String
    var fetchMealsAction: () -> Void

    var body: some View {
        HStack {
            TextField(selectedSearchOption.getAsExample(), text: $searchQuery)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .accessibilityLabel(selectedSearchOption.getAsExample())
                .accessibilityValue(searchQuery)
                .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize))
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







struct MealsList: View {
    @ObservedObject var viewModel: MealsViewModel
    @ObservedObject var detailsViewModel: MealDetailViewModel

    var body: some View {
        List(viewModel.meals) { meal in
            NavigationLink(destination: MealDetailView(viewModel: detailsViewModel, mealId: meal.id ?? "")) {
                Text(meal.strMeal ?? "")
                    .accessibilityLabel(meal.strMeal ?? "")
                    .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize))
            }
        }
        .cornerRadius(8)
    }
}

struct NoResultsView: View {
    var selectedSearchOption: SearchOption

    var body: some View {
        Text(String.Localization.no_results(selectedSearchOption.rawValue))
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
            .padding()
            .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize))
        Spacer()
    }
}


enum SearchOption: String, CaseIterable {
    case category
    case name
    case ingredient
    case area

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
