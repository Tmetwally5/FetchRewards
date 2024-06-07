//
//  ContentView.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appDependencies: AppDependencies

    var body: some View {
        MealsListView(
            mealDetailViewModel: appDependencies.mealDetailViewModel,
            mealsViewModel: appDependencies.mealsViewModel,
            reachability: appDependencies.reachability
        )
    }
}
