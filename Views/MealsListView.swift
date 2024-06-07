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
            VStack (spacing:10){
                Text("Search By")
                Picker("Select Search Option", selection: $selectedSearchOption) {
                    ForEach(SearchOption.allCases, id: \.self) { option in
                        Text(option.rawValue.capitalized)
                    }
                }
                    .onChange(of: selectedSearchOption) { _ , newValue in
                    viewModel.meals = []
                    if newValue == .name{
                        searchQuery = ""
                        viewModel.fetchMeals(searchOption: newValue, query: searchQuery)
                    }else if newValue == .category{
                        searchQuery = category
                        viewModel.fetchMeals(searchOption: newValue, query: searchQuery)
                    }else{
                        searchQuery = ""
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                if selectedSearchOption == .category {
                    if !viewModel.categories.isEmpty {
                        HStack{
                            Spacer()
                            Text("Select a category")
                            Spacer()
                            Picker("Select Category", selection: $searchQuery) {
                                ForEach(viewModel.categories, id: \.id) { category in
                                    Text(category.strCategory ?? "")
                                                        .tag(category.strCategory ?? "")
                                }
                            }
                                .pickerStyle(DefaultPickerStyle()).frame(width:150,height:40).background(Color.blue).cornerRadius(8)
                           // Spacer()
                        }.tint(.white).background(Color.gray.opacity(0.2)).cornerRadius(8)                        .onReceive(viewModel.$categories) { _ in
                            if !viewModel.categories.isEmpty && searchQuery.isEmpty {
                                searchQuery = viewModel.categories[0].strCategory ?? ""
                            }
                        }.onChange(of: searchQuery){_ ,newValue in
                             category = newValue
                        }

                    } else {
                        ProgressView()
                    }
                } else {
                    HStack{
                        TextField(selectedSearchOption.getAsExample(), text: $searchQuery)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        if selectedSearchOption != .name{
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
                }.cornerRadius(8)
            }.padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)).onAppear(perform: {
                viewModel.fetchCategories()
            }).onChange(of: searchQuery, {
                if selectedSearchOption != .area && selectedSearchOption != .ingredient{
                    viewModel.fetchMeals(searchOption: selectedSearchOption, query: searchQuery)
                }
            }).navigationBarTitle("Recipes")
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
