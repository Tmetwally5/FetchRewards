//
//  MealsListView.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

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
    @State private var category: String = ""
    @State private var selectedSearchOption: SearchOption = .category

    init(networkService: NetworkService) {
        self.viewModel = MealsViewModel(networkService: networkService)
        self.detailsViewModel = MealDetailViewModel(networkService: networkService)
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                SearchOptionPicker(selectedSearchOption: $selectedSearchOption)
                    .onChange(of: selectedSearchOption) { _, newValue in
                        handleSearchOptionChange(newValue)
                    }
                    .padding(.bottom, 10)

                if selectedSearchOption == .category {
                    CategoryPickerView(viewModel: viewModel, searchQuery: $searchQuery, category: $category)
                } else {
                    SearchTextFieldView(
                        selectedSearchOption: selectedSearchOption,
                        searchQuery: $searchQuery,
                        fetchMealsAction: {
                            viewModel.fetchMeals(searchOption: selectedSearchOption, query: searchQuery)
                        }
                    )
                }

                if let errorMessage = viewModel.errorMessage {
                    ErrorMessageView(errorMessage: errorMessage)
                }

                MealsList(viewModel: viewModel, detailsViewModel: detailsViewModel)
            }
            .padding(.horizontal, 5)
            .onAppear {
                viewModel.fetchCategories()
            }
            .onChange(of: searchQuery) { _ in
                if selectedSearchOption != .area && selectedSearchOption != .ingredient {
                    viewModel.fetchMeals(searchOption: selectedSearchOption, query: searchQuery)
                }
            }
            .navigationBarTitle("Recipes")
        }
    }

    private func handleSearchOptionChange(_ newValue: SearchOption) {
        viewModel.meals = []
        if newValue == .name {
            searchQuery = ""
            viewModel.fetchMeals(searchOption: newValue, query: searchQuery)
        } else if newValue == .category {
            searchQuery = category
            viewModel.fetchMeals(searchOption: newValue, query: searchQuery)
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
                .frame(width: 200, height: 40)
                .background(Color.blue)
                .cornerRadius(8)
                .tint(.white)
                Spacer()
            }
            .background(Color.gray.opacity(0.2))
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

struct ErrorMessageView: View {
    var errorMessage: String

    var body: some View {
        Text(errorMessage)
            .foregroundColor(.red)
            .padding()
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

struct MealsListView_Previews: PreviewProvider {
    static var previews: some View {
        MealsListView(networkService: NetworkService())
    }
}
