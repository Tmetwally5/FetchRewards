//
//  MealsListView.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//
//
import SwiftUI

struct MealsListView: View {
    @ObservedObject var mealsViewModel: MealsViewModel
    @ObservedObject var detailsViewModel: MealDetailViewModel
    @ObservedObject var reachability:Reachability
    @State private var searchQuery: String = ""
    @State private var category: String = ""
    @State private var selectedSearchOption: SearchOption = .category
    
    init(mealDetailViewModel: MealDetailViewModel,mealsViewModel:MealsViewModel,reachability:Reachability) {
        self.mealsViewModel = mealsViewModel
        self.detailsViewModel = mealDetailViewModel
        self.reachability = reachability
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                if !reachability.isConnected {
                    Spacer()
                    Text("No internet connection. Please check your connection.")
                        .foregroundColor(.red)
                        .padding()
                    Spacer()
                } else {
                    SearchOptionPicker(selectedSearchOption: $selectedSearchOption)
                        .onChange(of: selectedSearchOption) { _, newValue in
                            handleSearchOptionChange(newValue)
                        }
                        .padding(.bottom, 10)
                    
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
            .onChange(of: searchQuery) { _ , _ in
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
            .navigationBarTitle("Recipes")
        }
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
            Text("Search By")
            Picker("Select Search Option", selection: $selectedSearchOption) {
                ForEach(SearchOption.allCases, id: \.self) { option in
                    Text(option.rawValue.capitalized)
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
                Text("Select a category")
                Spacer()
                Picker("Select Category", selection: $searchQuery) {
                    ForEach(viewModel.categories, id: \.id) { category in
                        Text(category.strCategory ?? "")
                            .tag(category.strCategory ?? "")
                    }
                }
                .pickerStyle(DefaultPickerStyle())
                
                .background(Color.blue)
                .cornerRadius(8)
                .tint(.white)
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
            if selectedSearchOption != .name {
                Button(action: fetchMealsAction) {
                    Text("Search")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 100, height: 40)
                        .background(Color.blue)
                        .cornerRadius(8)
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
            }
        }
        .cornerRadius(8)
    }
}

struct NoResultsView: View {
    var selectedSearchOption: SearchOption

    var body: some View {
        Text("We did not find any recipes for this \(selectedSearchOption.rawValue). Try searching for something different.")
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
            .padding()
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
            return "e.g., Canadian, Mexican"
        case .category:
            return "e.g., Seafood, Dessert"
        case .ingredient:
            return "e.g., chicken breast, tomatoes"
        case .name:
            return "e.g., Arrabiata, Margherita"
        }
    }
}
