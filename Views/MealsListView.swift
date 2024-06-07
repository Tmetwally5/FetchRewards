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
                Text("Search By")
                Picker("Select Search Option", selection: $selectedSearchOption) {
                    ForEach(SearchOption.allCases, id: \.self) { option in
                        Text(option.rawValue.capitalized)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                if selectedSearchOption == .category {
                    // Display category picker
                    if !viewModel.categories.isEmpty {
                        HStack{
                            Spacer()
                            Text("Select a category:")
                            Spacer()
                            Picker("Select Category", selection: $searchQuery) {
                                ForEach(viewModel.categories, id: \.id) { category in
                                    Text(category.strCategory ?? "")
                                                        .tag(category.strCategory ?? "")
                                }
                            }
                            .pickerStyle(DefaultPickerStyle())
                            Spacer()
                        }.background(Color.gray.opacity(0.2))

                    } else {
                        ProgressView()
                    }
                } else {
                    HStack{
                        TextField(selectedSearchOption.getAsExample(), text: $searchQuery)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: {
                            viewModel.fetchMeals(searchOption: selectedSearchOption, query: searchQuery)
                        }) {
                            Text("Search")
                                .foregroundColor(.white)
                                .padding().frame(width: 100, height: 40)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }

                    }
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
            .padding().onAppear(perform: {
                viewModel.fetchCategories()
            }).onChange(of: searchQuery, {
                viewModel.fetchMeals(searchOption: selectedSearchOption, query: searchQuery)
            })
        }
    }
}

enum SearchOption: String, CaseIterable {
    case category
    case name
    case ingredient
    case area
    func getAsExample()->String{
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
