//
//  HomeScreen.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 16/12/2024.
//


import SwiftUI

protocol HomeScreenDelegate: AnyObject, Sendable {
    @MainActor func goToItemList()
    @MainActor func goToItemDetails()
    @MainActor func logout()
}

struct HomeScreen: View {
    var homeScreenDelegate: HomeScreenDelegate?
    
    init(homeScreenDelegate: HomeScreenDelegate?) {
        self.homeScreenDelegate = homeScreenDelegate
    }
    
    var body: some View {
        VStack {
            Text("Home")
            Button("Go Item List") {
                homeScreenDelegate?.goToItemList()
            }
            Button("Go Item Details") {
                homeScreenDelegate?.goToItemDetails()
            }
            Button("logout") {
                homeScreenDelegate?.logout()
            }
        }
    }
}

#Preview {
    HomeScreen(homeScreenDelegate: nil)
}
