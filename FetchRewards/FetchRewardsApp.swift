//
//  FetchRewardsApp.swift
//  FetchRewards
//
//  Created by Taha Metwally on 6/6/2024.
//

import SwiftUI

@main
struct FetchRewardsApp: App {
    @StateObject private var appDependencies = AppDependencies()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appDependencies)
        }
    }
}
